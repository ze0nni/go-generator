package r;

import defold.types.Hash;
import model.*;

@:enum abstract HeroModel(String) to String {
    
    var barbarian: HeroModel = "hero_barbarian";
    static var barbarian_data: HeroModelData = {
        model: barbarian,
        unitModel: UnitModel.hero_barbarian,
        
        st : 16,
        
        dx : 5,
        
        iq : 5,
        
        ht : 14,
        
        inventory1 : [poison_black,poison_blue,poison_green,poison_red,poison_white],
        
        inventoryEquip1 : [axe],
        
    }
    
    var cleric: HeroModel = "hero_cleric";
    static var cleric_data: HeroModelData = {
        model: cleric,
        unitModel: UnitModel.hero_cleric,
        
        st : 12,
        
        dx : 6,
        
        iq : 14,
        
        ht : 8,
        
        inventory1 : [poison_black,poison_blue,poison_green,poison_red,poison_white],
        
        inventoryEquip1 : [staff],
        
    }
    
    var warrior: HeroModel = "hero_warrior";
    static var warrior_data: HeroModelData = {
        model: warrior,
        unitModel: UnitModel.hero_warrior,
        
        st : 12,
        
        dx : 8,
        
        iq : 8,
        
        ht : 12,
        
        inventory1 : [poison_black,poison_blue,poison_green,poison_red,poison_white],
        
        inventoryEquip1 : [sword],
        
    }
    
    var wizard: HeroModel = "hero_wizard";
    static var wizard_data: HeroModelData = {
        model: wizard,
        unitModel: UnitModel.hero_wizard,
        
        st : 7,
        
        dx : 7,
        
        iq : 19,
        
        ht : 7,
        
        inventory1 : [poison_black,poison_blue,poison_green,poison_red,poison_white],
        
        inventoryEquip1 : [dagger],
        
    }
    

    static public var total: Int = 4;
        static var _all: Array<{model: HeroModel, data: HeroModelData}> = [
        
        { model: barbarian, data: barbarian_data },
        
        { model: cleric, data: cleric_data },
        
        { model: warrior, data: warrior_data },
        
        { model: wizard, data: wizard_data },
        
    ];

    static public function get(model: HeroModel): HeroModelData {
        return switch (model) {
            
            case HeroModel.barbarian: barbarian_data;
            
            case HeroModel.cleric: cleric_data;
            
            case HeroModel.warrior: warrior_data;
            
            case HeroModel.wizard: wizard_data;
            
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