using Godot;

public class YourClassName : Node2D
{
private void _on_Button_pressed()
{
GetTree().ChangeScene("res://home.tscn");
}
}

/*Note that the C# code uses Override instead of _on_Button_pressed() and GetTree() instead of get_tree().
Also, make sure to replace "YourClassName" with the actual name of your script.*/





