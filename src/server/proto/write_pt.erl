-module(write_pt).
-export([write/2]).
-define(CMD_10001,[int32,int16,string,{array,2,[string,int32,string]},int32]).

write(Cmd_List,Data) ->
    %Data = [16,20,"hi","ji",1,"jiji","you",2,"upi",14],
    %L = [int32,int16,string,{array,2,[string,int32,string]},int32],

    {_RestData,ListBin} = write_each(Cmd_List,Data,[]),
    %io:format("writing:~p~n",[ListBin]),
    read_pt:read_pt(10001,list_to_binary(ListBin)).


write_each([Type|LastL],Data,BinList) ->
    case Type of
        int32 ->
            [Int32 | RestData] = Data,
            NewBinList = BinList ++ [<<Int32:32>>],
            write_each(LastL,RestData,NewBinList);
        int16 ->
            [Int16 | RestData] = Data,
            NewBinList = BinList ++ [<<Int16:16>>],
            write_each(LastL,RestData,NewBinList);
        string ->
            [String | RestData ] = Data,
            StrLen = string:len(String),
            NewBinList = BinList ++ [<<StrLen:16,(list_to_binary(String))/binary>>],
            write_each(LastL,RestData,NewBinList);
        {array,N,TypeList} ->
            io:format("array:N ~p,TypeList ~p~n",[N,TypeList]),
            TempBinList = BinList ++ [<<N:16>>],
            {RestData,ResultBinList} = writing_array(N,TypeList,Data,[]),
            NewBinList = TempBinList ++ ResultBinList,
            write_each(LastL,RestData,NewBinList);
        Other ->
            io:format("~p~n",[Other]),
            {error,no_match}
    end;

write_each([],Data,BinList) ->
    {Data,BinList}.


writing_array(N,TypeList,Data,BinList) when N >0 ->
    {RestData,ResultBinList} = write_each(TypeList,Data,[]),
    NewBinList = ResultBinList ++ BinList,
    writing_array(N-1,TypeList,RestData,NewBinList);

writing_array(_,_TypeList,Data,BinList) ->
    {Data,BinList}.
            
