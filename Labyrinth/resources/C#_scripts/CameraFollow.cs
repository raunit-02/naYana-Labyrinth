using Godot;

public class CameraFollow : Camera
{
[Export]
public float distance = 4.0f;

[Export]
public float height = 2.0f;

public override void _Ready()
{
    SetPhysicsProcess(true);
    SetAsToplevel(true);
}

public override void _PhysicsProcess(float delta)
{
    var target = GetParent().GlobalTransform.origin;
    var pos = GlobalTransform.origin;
    var up = new Vector3(0, 1, 0);
    
    var offset = pos - target;
    
    offset = offset.Normalized() * distance;
    offset.y = height;
    
    pos = target + offset;
    
    LookAtFromPosition(pos, target, up);
}

}