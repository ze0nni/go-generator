package r;

import defold.types.Hash;
import model.*;

@:enum abstract UnitModel(String) to String {
    {{ range .Entry }}
    var {{.Name}}: UnitModel = "unit_{{.Name}}";
    static var {{.Name}}_data: UnitModelData = {
        model: {{.Name}},
        {{ range .Property}}
        {{.Key}} : {{.Value}},
        {{ end }}
    }
    {{ end }}

    static public var total: Int = {{len .Entry}};
        static var _all: Array<{model: UnitModel, data: UnitModelData}> = [
        {{ range .Entry }}
        { model: {{.Name}}, data: {{.Name}}_data },
        {{ end }}
    ];

    static public function get(model: UnitModel): UnitModelData {
        return switch (model) {
            {{ range .Entry }}
            case UnitModel.{{.Name}}: {{.Name}}_data;
            {{ end }}
        }
    }

    static public function at(index: Int): UnitModelData {
        return _all[index].data;
    }

    inline static public function all(consumer: UnitModel -> UnitModelData -> Void) {
        for (i in _all) {
            consumer(i.model, i.data);
        }
    }

    @:to function toHash(): Hash {
        return Defold.hash(this);
    }
}