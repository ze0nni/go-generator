package r;

import defold.types.Hash;
import model.*;

@:enum abstract UnitModel(String) to String {
    
    var hero_barbarian: UnitModel = "unit_hero_barbarian";
    static var hero_barbarian_data: UnitModelData = {
        model: hero_barbarian,
        
        actionPoints : 1,
        
        health : 25,
        
        damage : 3,
        
        damageRange : 5,
        
        defence : 5,
        
    }
    
    var hero_cleric: UnitModel = "unit_hero_cleric";
    static var hero_cleric_data: UnitModelData = {
        model: hero_cleric,
        
        actionPoints : 1,
        
        health : 25,
        
        damage : 3,
        
        damageRange : 5,
        
        defence : 5,
        
    }
    
    var hero_warrior: UnitModel = "unit_hero_warrior";
    static var hero_warrior_data: UnitModelData = {
        model: hero_warrior,
        
        actionPoints : 1,
        
        health : 25,
        
        damage : 3,
        
        damageRange : 5,
        
        defence : 5,
        
    }
    
    var hero_wizard: UnitModel = "unit_hero_wizard";
    static var hero_wizard_data: UnitModelData = {
        model: hero_wizard,
        
        actionPoints : 1,
        
        health : 25,
        
        damage : 3,
        
        damageRange : 5,
        
        defence : 5,
        
    }
    
    var boar: UnitModel = "unit_boar";
    static var boar_data: UnitModelData = {
        model: boar,
        
        actionPoints : 1,
        
        health : 20,
        
        damage : 2,
        
        damageRange : 2,
        
        defence : 7,
        
    }
    
    var rat: UnitModel = "unit_rat";
    static var rat_data: UnitModelData = {
        model: rat,
        
        actionPoints : 1,
        
        health : 5,
        
        damage : 1,
        
        damageRange : 2,
        
        defence : 2,
        
    }
    
    var slug_red: UnitModel = "unit_slug_red";
    static var slug_red_data: UnitModelData = {
        model: slug_red,
        
        actionPoints : 1,
        
        health : 3,
        
        damage : 1,
        
        damageRange : 0,
        
        defence : 0,
        
    }
    
    var zombie: UnitModel = "unit_zombie";
    static var zombie_data: UnitModelData = {
        model: zombie,
        
        actionPoints : 1,
        
        health : 30,
        
        damage : 2,
        
        damageRange : 0,
        
        defence : 10,
        
    }
    

    static public var total: Int = 8;
        static var _all: Array<{model: UnitModel, data: UnitModelData}> = [
        
        { model: hero_barbarian, data: hero_barbarian_data },
        
        { model: hero_cleric, data: hero_cleric_data },
        
        { model: hero_warrior, data: hero_warrior_data },
        
        { model: hero_wizard, data: hero_wizard_data },
        
        { model: boar, data: boar_data },
        
        { model: rat, data: rat_data },
        
        { model: slug_red, data: slug_red_data },
        
        { model: zombie, data: zombie_data },
        
    ];

    static public function get(model: UnitModel): UnitModelData {
        return switch (model) {
            
            case UnitModel.hero_barbarian: hero_barbarian_data;
            
            case UnitModel.hero_cleric: hero_cleric_data;
            
            case UnitModel.hero_warrior: hero_warrior_data;
            
            case UnitModel.hero_wizard: hero_wizard_data;
            
            case UnitModel.boar: boar_data;
            
            case UnitModel.rat: rat_data;
            
            case UnitModel.slug_red: slug_red_data;
            
            case UnitModel.zombie: zombie_data;
            
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