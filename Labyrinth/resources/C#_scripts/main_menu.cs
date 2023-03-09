using Godot;

public class YourClassName : Control
{
[Export]
public PackedScene mainGameScene;

private void _on_NewGameButton_button_up()
{
    GetTree().ChangeScene(mainGameScene.ResourcePath);
}
}

/*Note that the C# code uses GetTree() instead of get_tree() 
and ResourcePath instead of resource_path. 
Also, make sure to replace "YourClassName" with the actual name of your script.*/