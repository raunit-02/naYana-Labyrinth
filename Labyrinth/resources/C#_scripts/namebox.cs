using Godot;

public class YourClassName : Control
{
private LineEdit line_edit;
private string playerName = " ";

public override void _Ready()
{
    line_edit = GetNode<LineEdit>("PlayerName");
    line_edit.GrabFocus();
}

private void _on_Button_pressed()
{
    playerName = line_edit.Text;
    QueueFree();
    SavePN(playerName);
    GetTree().ChangeScene("res://intro2.tscn");
}

private void SavePN(string datatosave)
{
    var file = new File();
    file.Open("res://user_data/playerName.txt", File.ModeFlags.Write);
    file.StoreString(datatosave);
    file.Close();
}
}

/* Note that the C# code uses GetNode<>() instead of get_node(), Override instead of _ready(), and File.
ModeFlags.Write instead of File.WRITE. Also, make sure to replace "YourClassName" 
with the actual name of your script.*/