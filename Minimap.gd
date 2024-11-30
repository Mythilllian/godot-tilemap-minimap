extends Control

@export var camera_node: NodePath
@export var tilemap_nodes: Array[NodePath]
@export var cell_colors: Dictionary
@export var zoom: float = 1.0

@onready var camera: Camera2D = get_node(camera_node)
var tilemaps: Array[TileMap] = []

func _ready():
	for node_path in tilemap_nodes:
		var tilemap: TileMap = get_node(node_path)
		tilemaps.append(tilemap)

func get_cells(tilemap: TileMap, id: int) -> Array[Vector2i]:
	return tilemap.get_used_cells_by_tileset_id(id)

func _draw():
	draw_set_transform_matrix(Transform2D(0, size / 2))
	
	for tilemap in tilemaps:
		var camera_position = camera.get_screen_center()
		var camera_cell = tilemap.local_to_map(camera_position)
		var tilemap_offset = camera_cell + (camera_position - tilemap.map_to_local(camera_cell)) / tilemap.cell_size

		for id in cell_colors.keys():
			var color: Color = cell_colors[id]
			var cells = get_cells(tilemap, id)
			for cell in cells:
				var position = (cell - tilemap_offset) * zoom
				draw_rect(Rect2(position, Vector2.ONE * zoom), color)

func _process(_delta):
	queue_redraw() 
