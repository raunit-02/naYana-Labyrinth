using Godot;
using System;

public class DialogBox : TextureRect
{
[Export]
public string dialogPath = "";

[Export(PropertyHint.Range, "0.01,1,0.01")]
public float textSpeed = 0.05f;

private Array dialog;
private int phraseNum = 0;
private bool finished = false;

public override void _Ready()
{
    GetNode<Timer>("Timer").WaitTime = textSpeed;
    dialog = GetDialog();
    if (dialog == null)
    {
        GD.Print("Dialog not found");
        return;
    }
    NextPhrase();
}

public override void _Process(float delta)
{
    GetNode<Node2D>("Indicator").Visible = finished;
    if (Input.IsActionJustPressed("ui_accept"))
    {
        if (finished)
        {
            NextPhrase();
        }
        else
        {
            GetNode<RichTextLabel>("Text").VisibleCharacters = GetNode<RichTextLabel>("Text").Text.Length;
        }
    }
}

private Array GetDialog()
{
    var f = new File();
    if (!f.FileExists(dialogPath))
    {
        GD.Print("File does not exist");
        return null;
    }

    f.Open(dialogPath, (int)File.ModeFlags.Read);
    var json = f.GetAsText();
    f.Close();

    var output = JSON.Parse(json);
    if (output.Type == Variant.Type.Array)
    {
        return output.Array();
    }
    else
    {
        return new Array();
    }
}

private string LoadPN()
{
    var file = new File();
    file.Open("res://user_data/playerName.txt", (int)File.ModeFlags.Read);
    var playerName = file.GetAsText();
    file.Close();
    return playerName;
}

private void NextPhrase()
{
    var playerName = LoadPN();
    if (phraseNum >= dialog.Count)
    {
        QueueFree();
        GetTree().ChangeScene("res://delay.tscn");
        return;
    }

    finished = false;

    if (dialog[phraseNum]["Name"].ToString() == "Player")
    {
        GetNode<BBCodeLabel>("Name").Text = playerName;
    }
    else
    {
        GetNode<BBCodeLabel>("Name").Text = dialog[phraseNum]["Name"].ToString();
    }

    if ((int)dialog[phraseNum]["Binary"] == 1)
    {
        GetNode<RichTextLabel>("Text").BbcodeText = playerName + dialog[phraseNum]["Text"].ToString();
    }
    else
    {
        GetNode<RichTextLabel>("Text").BbcodeText = dialog[phraseNum]["Text"].ToString();
    }

    GetNode<RichTextLabel>("Text").VisibleCharacters = 0;

    var f = new File();
    var img = "res://resources/dialogs/friendsIntro/" + dialog[phraseNum]["Name"].ToString() + dialog[phraseNum]["Emotion"].ToString() + ".png";
    if (f.FileExists(img))
    {
        GetNode<TextureRect>("Potrait").Texture = GD.Load<Texture>(img);
    }
    else
    {
        GetNode<TextureRect>("Potrait").Texture = null;
    }

    while (GetNode<RichTextLabel>("Text").VisibleCharacters < GetNode<RichTextLabel>("Text").Text.Length)
    {
        GetNode<RichTextLabel>("Text").VisibleCharacters += 1;

        GetNode<Timer>("Timer").Start();
        yield(GetNode<Timer>("Timer"), "timeout");
    }

    finished = true;
    phraseNum += 1;
}

}
