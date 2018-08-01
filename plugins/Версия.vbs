' �������� ������ ��� �������� ������
'
' ����� ����� <slava@berezka.dp.ua>
'��� ��� ����� ������� ������ "��������" � ��������������, ��� ��� ������ ����� �� ������ :)
'
'�������� �������� ���:
'����������� OnIdle, ���� ����� ������� � � Caption ���� *, ����� ������ ����.
'����� ������ ����� (OnFileSaved) ���� ���� �����, �������� ������ ��������� ������. ��� �������� ������������ � ������ ������ ���� ����������� ����� � ����� � ������� ������ ������ � ����� ������������ ��� ���.
'��: ������� ���� ���� �� ������� BeforeSaved, ���� �� ����� � �� ����� ���� �� ���������� ���� ������ ���.

':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'==================================================
Sub Configurator_OnFileSaved(W)
    Dim ask_ch

    if W.Type = 1 and fst = 0 then
        Set DocFrm = Windows.ActiveWnd.Document
        if DocFrm = docWorkBook then
            Set DocFrm = DocFrm.Page(0)
        else
            exit Sub
        end if
        DialogTxtStrings = Split(DocFrm.Stream, vbCrLf)
        DialogTxtFunction = DialogTxtStrings
        Level = ""
        find_ver = 0
        for i = 0 to UBound(DialogTxtStrings)
            if i = 2 then
                Coord = Split(Mid(DialogTxtStrings(i), 3), """,""")
                CoordX = CStr(Coord(14) - 57)
                CoordY = CStr(Coord(15) - 12)
            end If
            if i > 3 then
                NextStr = DialogTxtStrings(i)
                if Level = "Controls" then
                    Do while right(NextStr, 2) <> "},"  and i < UBound(DialogTxtStrings)
                        i = i + 1
                        NextStr = NextStr + vbCrLf + DialogTxtStrings(i)
                    loop
                    IdentPos = 12
                    Params = Split(NextStr, """,""")
                    if UBound(Params) > 12 then
                        if (Params(1) = "STATIC") then
                            start_num = InStr(1,Params(0),"Ver")
                            if start_num>0 then
    '                           Message mid(Params(0),1,5), mNone
                                ver_num = mid(Params(0),(start_num+15),3)
                                old_date = mid(Params(0),(start_num+4),10)
                                old_ver = ver_num
                                if ver_num = "" then
                                    ver_num = 0
                                else
                                    ver_num = int(ver_num)
                                end if
                                if ver_num = 0 then
                                    ver_num = 1
                                else
                                    ver_num = ver_num + 1
                                end If
                                ver_num = CStr(ver_num)
                                ver_date = CStr(Date)
                                ver_start_str = left(Params(0), (start_num-1))
                                Params(0) = ver_start_str+"Ver "+ver_date+"_"+ver_num
    '                            a = int("a")
                                DialogTxtFunction(i) = Join(Params,""",""")
    '                           Message DialogTxtFunction(i), mNone
                                find_ver = 1
                            end if
                        end if
                    end if
                end if
            end if
            if left(NextStr, 9) = "{""Fixed""," then
                Level = "Table"
            elseif left(NextStr, 12) = "{""Controls""," then
                Level = "Controls"
            end if
        Next

        if Windows.ActiveWnd = Cal then
            str = vbCrLf+"������� ������: "+old_date+"_"+old_ver+vbCrLf+"�������� �� ������: "+CStr(Date)+"_"+ver_num
            ask_ch = MsgBox("�������� ������?"+str, 65,W.Name)
            if ask_ch = 1 then
                if find_ver = 0 then
                    GetDefaultString = "{""Ver "+CStr(Date)+"_0"+""",""STATIC"",""1342177280"","""+CoordX+""","""+CoordY+""",""52"",""8"",""0"",""0"",""4154"","""","""","""",""0"",""U"",""0"",""0"",""0"",""0"",""128"","""","""","""",""0"",""-8"",""0"",""0"",""0"",""400"",""0"",""0"",""0"",""204"",""1"",""2"",""1"",""34"",""MS Reference Sans Serif"",""-1"",""-1"",""0"",""��������"",""{""""0"""",""""0""""}""}"
                    DlgBlock = GetDefaultString
                    WorkString = Ubound(DialogTxtStrings) - 1
                    DialogTxtStrings(WorkString) = Left(DialogTxtStrings(WorkString), Len(DialogTxtStrings(WorkString)) - 2) + _
                    "," + vbCrLf + DlgBlock + "},"
                    DocFrm.Stream = Join(DialogTxtStrings, vbCrLf)
                else
                    DocFrm.Stream = Join(DialogTxtFunction, vbCrLf)
                end if
                fst = 1
                W.Save
                fst = 0
                Cal = 0
            end if
        end if
    end if
End Sub

Sub Configurator_OnIdle()

    if Windows.ActiveWnd is Nothing then exit sub

    if (InStr(1,Windows.ActiveWnd.Caption,"�������")<>0) and (InStr(1,Windows.ActiveWnd.Caption,"*")<>0) then

        Cal = Windows.ActiveWnd.hWnd
    end if
End Sub

fst=0
Cal=0