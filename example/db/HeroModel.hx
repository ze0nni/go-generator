package r;

import defold.types.Hash;
import model.*;

@:enum abstract HeroModel(String) to String {
    {{ range .Entry }}
    var {{.Name}}: HeroModel = "hero_{{.Name}}";
    static var {{.Name}}_data: HeroModelData = {
        model: {{.Name}},
        unitModel: UnitModel.hero_{{.Name}},
        {{ range .Property}}
        {{.Key}} : {{.Value}},
        {{ end }}
    }
    {{ end }}

    static public var total: Int = {{len .Entry}};
        static var _all: Array<{model: HeroModel, data: HeroModelData}> = [
        {{ range .Entry }}
        { model: {{.Name}}, data: {{.Name}}_data },
        {{ end }}
    ];

    static public function get(model: HeroModel): HeroModelData {
        return switch (model) {
            {{ range .Entry }}
            case HeroModel.{{.Name}}: {{.Name}}_data;
            {{ end }}
        }
    }

    static public function at(index: Int): HeroModelData {
        return _all[index].data;
    }

    inline static public function all(consumer: HeroModel -> HeroModelData -> Void) {
        for (i in _all) {
            consumer(i.model, i.data);
        }
    }

    @:to function toHash(): Hash {
        return Defold.hash(this);
    }
}