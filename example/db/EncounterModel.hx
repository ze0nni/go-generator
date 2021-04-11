package r;

import defold.types.Hash;
import model.*;

@:enum abstract EncounterModel(String) to String {
    {{ range .Entry }}
    var {{.Name}}: EncounterModel = "encounter_{{.Name}}";
    static var {{.Name}}_data: EncounterModelData = {
        model: {{.Name}},
        {{ range .Property}}
        {{.Key}} : {{.Value}},
        {{ end }}
    }
    {{ end }}

    static public function get(model: EncounterModel): EncounterModelData {
        return switch (model) {
            {{ range .Entry }}
            case EncounterModel.{{.Name}}: {{.Name}}_data;
            {{ end }}
        }
    }

    static var _all: Array<{model: EncounterModel, data: EncounterModelData}> = [
        {{ range .Entry }}
        { model: {{.Name}}, data: {{.Name}}_data },
        {{ end }}
    ];

    inline static public function all(consumer: EncounterModel -> EncounterModelData -> Void) {
        for (i in _all) {
            consumer(i.model, i.data);
        }
    }

    @:to function toHash(): Hash {
        return Defold.hash(this);
    }
}