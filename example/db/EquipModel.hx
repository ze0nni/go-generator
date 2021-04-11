package r;

import defold.types.Hash;
import model.*;

@:enum abstract EquipModel(String) to String {
    {{ range .Entry }}
    var {{.Name}}: EquipModel = "equip_{{.Name}}";
    static var {{.Name}}_data: EquipModelData = {
        model: {{.Name}},
        {{ range .Property}}
        {{.Key}} : {{.Value}},
        {{ end }}
    }
    {{ end }}

    static public function get(model: EquipModel): EquipModelData {
        return switch (model) {
            {{ range .Entry }}
            case EquipModel.{{.Name}}: {{.Name}}_data;
            {{ end }}
        }
    }

    
    static var _all: Array<{model: EquipModel, data: EquipModelData}> = [
        {{ range .Entry }}
        { model: {{.Name}}, data: {{.Name}}_data },
        {{ end }}
    ];

    inline static public function all(consumer: EquipModel -> EquipModelData -> Void) {
        for (i in _all) {
            consumer(i.model, i.data);
        }
    }

    @:to function toHash(): Hash {
        return Defold.hash(this);
    }
}