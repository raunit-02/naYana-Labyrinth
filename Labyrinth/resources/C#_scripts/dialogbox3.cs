using Godot;
using System;

public class DialogController : TextureRect
{
[Export]
public string DialogPath = "";

[Export]
public float TextSpeed = 0.05f;

private Array dialog;

private int phraseNum = 0;
private bool finished = false;

public override void _Ready()
{
    GetNode<Timer>("Timer").WaitTime = TextSpeed;
    dialog = GetDialog();
    if (dialog == null)
    {
        GD.Print("Dialog not found.");
        return;
    }
    nextPhrase();
}

public override void _Process(float delta)
{
    GetNode<Control>("Indicator").Visible = finished;
    if (Input.IsActionJustPressed("ui_accept"))
    {
        if (finished)
        {
            nextPhrase();
        }
        else
        {
            GetNode<Label>("Text").VisibleCharacters = GetNode<Label>("Text").Text.Length;
        }
    }
}

private Array GetDialog()
{
    var f = new File();
    if (!f.FileExists(DialogPath))
    {
        GD.Print("File does not exist.");
        return null;
    }
    f.Open(DialogPath, File.ModeFlags.Read);
    var json = f.GetAsText();
    var output = JSON.Parse(json);
    if (output.Type == VariantType.Array)
    {
        return (Array)output;
    }
    else
    {
        return new Array();
    }
}

private string LoadPlayerName()
{
    var file = new File();
    file.Open("res://user_data/playerName.txt", File.ModeFlags.Read);
    var playerName = file.GetAsText();
    return playerName;
}

private void nextPhrase()
{
    var playerName = LoadPlayerName();
    if (phraseNum >= dialog.Count)
    {
        QueueFree();
        GetTree().ChangeScene("res://delay.tscn");
        return;
    }
    finished = false;
    var nameLabel = GetNode<Label>("Name");
    if ((string)dialog[phraseNum]["Name"] == "Player")
    {
        nameLable.BbcodeText = playerName;
    }
    else
    {
        nameLabel.BbcodeText = (string)dialog[phraseNum]["Name"];
    }
    var textLabel = GetNode<Label>("Text");
    if ((int)dialog[phraseNum]["Binary"] == 1)
    {
        textLabel.BbcodeText = playerName + (string)dialog[phraseNum]["Text"];
    }
    else
    {
        textLabel.BbcodeText = (string)dialog[phraseNum]["Text"];
    }
    textLabel.VisibleCharacters = 0;
    var f = new File();
    var img = "res://resources/dialogs/friendsIntro/" + (string)dialog[phraseNum]["Name"] + (string)dialog[phraseNum]["Emotion"] + ".png";
    if (f.FileExists(img))
    {
        GetNode<TextureRect>("Portrait").Texture = ResourceLoader.Load<Texture>(img);
    }
    else
    {
        GetNode<TextureRect>("Portrait").Texture = null;
    }
    while (textLabel.VisibleCharacters < textLabel.Text.Length)
    {
        textLabel.VisibleCharacters += 1;
        GetNode<Timer>("Timer").Start();
        yield(GetNode<Timer>("Timer"), "timeout");
    }
    finished = true;
    phraseNum += 1;
}

}