using Godot;

public class DialogScript : TextureRect
{
[Export] public string dialogPath = "";
[Export] public float textSpeed = 0.05f;

private Godot.Collections.Array dialog;
private int phraseNum = 0;
private bool finished = false;

public override void _Ready()
{
    GetNode<Timer>("Timer").WaitTime = textSpeed;
    dialog = GetDialog();
    GD.Assert(dialog != null, "Dialog not Found");
    NextPhrase();
}

public override void _Process(float delta)
{
    GetNode<Control>("Indicator").Visible = finished;
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

private Godot.Collections.Array GetDialog()
{
    var f = new File();
    GD.Assert(f.FileExists(dialogPath), "File does not exist");

    f.Open(dialogPath, File.ModeFlags.Read);
    var json = f.GetAsText();

    var output = JSON.Parse(json);

    if (output is Godot.Collections.Array)
    {
        return (Godot.Collections.Array)output;
    }
    else
    {
        return new Godot.Collections.Array();
    }
}

private string LoadPlayerName()
{
    var file = new File();
    file.Open("res://user_data/playerName.txt", File.ModeFlags.Read);
    var playerName = file.GetAsText();
    return playerName;
}

private void NextPhrase()
{
    var playerName = LoadPlayerName();
    if (phraseNum >= dialog.Count)
    {
        QueueFree();
        GetTree().ChangeScene("res://light.tscn");
        return;
    }

    finished = false;

    if ((string)dialog[phraseNum]["Name"] == "Player")
    {
        GetNode<BBCodeLabel>("Name").Text = playerName;
    }
    else
    {
        GetNode<BBCodeLabel>("Name").Text = (string)dialog[phraseNum]["Name"];
    }

    if ((int)dialog[phraseNum]["Binary"] == 1)
    {
        GetNode<RichTextLabel>("Text").BbcodeText = playerName + (string)dialog[phraseNum]["Text"];
    }
    else
    {
        GetNode<RichTextLabel>("Text").BbcodeText = (string)dialog[phraseNum]["Text"];
    }

    GetNode<RichTextLabel>("Text").VisibleCharacters = 0;

    var f = new File();
    var img = "res://resources/dialogs/home_scene/" + (string)dialog[phraseNum]["Name"] + (string)dialog[phraseNum]["Emotion"] + ".png";
    if (f.FileExists(img))
    {
        GetNode<TextureRect>("Potrait").Texture = (Texture)ResourceLoader.Load(img);
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