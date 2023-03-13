using Godot;

public class DialogueBox : TextureRect
{
[Export]
public string dialogPath = "";

[Export]
public float textSpeed = 0.05f;

private Array dialog;
private int phraseNum = 0;
private bool finished = false;

private Timer timer;
private Label name;
private Label text;
private TextureRect portrait;
private Texture nullTexture;

public override void _Ready()
{
    timer = GetNode<Timer>("Timer");
    timer.WaitTime = textSpeed;
    
    name = GetNode<Label>("Name");
    text = GetNode<Label>("Text");
    portrait = GetNode<TextureRect>("Portrait");
    
    dialog = GetDialog();
    Debug.Assert(dialog != null, "Dialog not found");
    
    NextPhrase();
}

public override void _Process(float delta)
{
    GetNode<TextureRect>("Indicator").Visible = finished;
    
    if (Input.IsActionJustPressed("ui_accept"))
    {
        if (finished)
        {
            NextPhrase();
        }
        else
        {
            text.VisibleCharacters = text.Text.Length;
        }
    }
}

private Array GetDialog()
{
    var f = new File();
    Debug.Assert(f.FileExists(dialogPath), "File does not exist");
    
    f.Open(dialogPath, File.ModeFlags.Read);
    var json = f.GetAsText();
    
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

private void NextPhrase()
{
    if (phraseNum >= dialog.Count)
    {
        QueueFree();
        GetTree().ChangeScene("res://playerIntro.tscn");
        return;
    }
    
    finished = false;
    
    name.BbcodeText = (string)dialog[phraseNum]["Name"];
    text.BbcodeText = (string)dialog[phraseNum]["Text"];
    
    text.VisibleCharacters = 0;
    
    var f = new File();
    var img = "res://resources/dialogs/intro_scene/" + (string)dialog[phraseNum]["Name"] + (string)dialog[phraseNum]["Emotion"] + ".png";
    if (f.FileExists(img))
    {
        portrait.Texture = (Texture)f.Load(img);
    }
    else
    {
        portrait.Texture = nullTexture;
    }
    
    while (text.VisibleCharacters < text.Text.Length)
    {
        text.VisibleCharacters += 1;
        
        timer.Start();
        yield(timer, "timeout");
    }
    
    finished = true;
    phraseNum += 1;
}


}