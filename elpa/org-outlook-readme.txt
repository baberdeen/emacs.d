Commentary:

* Introduction:
Org mode lets you organize your tasks. However, sometimes you may wish
to integrate org-mode with outlook since your company forces you to
use Microsoft Outlook.  [[file:org-outlook.el][org-outlook.el]] allows:
- Creating Tasks from outlook items:
  - org-outlook-task. All selected items in outlook will be added to a
    task-list at current point. This version requires org-protocol and
    org-protocol.vbs.  The org-protocol.vbs has can be generated with
    the interactive function `org-outlook-create-vbs'.

- Open Outlook Links in org-mode

  - Requires org-outlook-location to be customized when using Outlook
    2007 (this way you don’t have to edit the registry).

This is based loosely on:
http://superuser.com/questions/71786/can-i-create-a-link-to-a-specific-email-message-in-outlook


Note that you may also add tasks using visual basic directly. The script below performs the following actions:

   - Move email to Personal Folders under folder "@ActionTasks" (changes GUID)
   - Create a org-mode task under heading "* Tasks" for the file `f:\Documents\org\gtd.org'
   - Note by replacing "@ActionTasks", "* Tasks" and
     `f:\Documents\org\gtd.org' you can modify this script to your
     personal needs.

The visual basic script for outlook is:



Sub CreateTaskFromItem()
    Dim T As Variant
    Dim Outlook As New Outlook.Application
    Dim orgfile As Variant
    Dim Pos As Integer
    Dim taskf As Object

    Set myNamespace = Outlook.GetNamespace("MAPI")
    Set myPersonalFolder = myNamespace.Folders.item("Personal Folders")
    Set allPersonalFolders = myPersonalFolder.Folders

    T = ""
    For Each Folder In allPersonalFolders
        If Folder.Name = "@ActionTasks" Then
            Set taskf = Folder
            Exit For
        End If
    Next

    If Outlook.Application.ActiveExplorer.Selection.Count > 0 Then
        For I = 1 To Outlook.Application.ActiveExplorer.Selection.Count
                Set objMail = Outlook.ActiveExplorer.Selection.item(I)
                Set objMail = objMail.Move(taskf)
                objMail.Save 'Maybe this will update EntryID
                T = T + "** TODO " + objMail.Subject + " :OFFICE:" + vbCrLf
                T = T + "[[outlook:" + objMail.EntryID + "][MESSAGE: " + objMail.Subject + " (" + objMail.SenderName + ")]]"
                T = T + vbCrLf + vbCrLf
                T = T + objMail.Body
                T = T + vbCrLf + vbCrLf
        Next
        ' Now that we have the org-mode tasks, add to org-mode file
        orgfile = GetFile("f:\Documents\org\gtd.org")
        Pos = InStr(1, orgfile, "* Tasks", vbTextCompare)
        orgfile = Mid(orgfile, 1, Pos + Len("* Tasks") + 1) + vbCrLf + T + Mid(orgfile, Pos + Len("* Tasks") + 1, Len(orgfile))
        orgfile = Replace(orgfile, vbCrLf, Chr(10)) ' Change to unix line endings.
        WriteFile "f:\Documents\org\gtd.org", orgfile
    Else
        MsgBox "No Message(s) Selected"
    End If

End Sub
