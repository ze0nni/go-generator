package r;

import defold.types.Hash;
import model.*;

@:enum abstract EncounterModel(String) to String {
    
    var little_rats: EncounterModel = "encounter_little_rats";
    static var little_rats_data: EncounterModelData = {
        model: little_rats,
        
        unit1 : [rat],
        
        unit1Count : [1,1,2,2,2,3],
        
        unit2 : [rat],
        
        unit2Count : [0,0,0,1,1,2],
        
    }
    
    var little_zombie: EncounterModel = "encounter_little_zombie";
    static var little_zombie_data: EncounterModelData = {
        model: little_zombie,
        
        unit1 : [zombie],
        
        unit1Count : [1,1,2,2,2,3],
        
        unit2 : [rat,rat,rat,zombie],
        
        unit2Count : [0,0,1,1,2],
        
    }
    

    static public function get(model: EncounterModel): EncounterModelData {
        return switch (model) {
            
            case EncounterModel.little_rats: little_rats_data;
            
            case EncounterModel.little_zombie: little_zombie_data;
            
        }
    }

    static var _all: Array<{model: EncounterModel, data: EncounterModelData}> = [
        
        { model: little_rats, data: little_rats_data },
        
        { model: little_zombie, data: little_zombie_data },
        
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