package r;

import defold.types.Hash;
import model.*;

@:enum abstract EquipModel(String) to String {
    
    var poison_black: EquipModel = "equip_poison_black";
    static var poison_black_data: EquipModelData = {
        model: poison_black,
        
        kind : Poison,
        
        stuck : true,
        
        rarity : 10,
        
    }
    
    var poison_blue: EquipModel = "equip_poison_blue";
    static var poison_blue_data: EquipModelData = {
        model: poison_blue,
        
        kind : Poison,
        
        stuck : true,
        
        rarity : 10,
        
    }
    
    var poison_green: EquipModel = "equip_poison_green";
    static var poison_green_data: EquipModelData = {
        model: poison_green,
        
        kind : Poison,
        
        stuck : true,
        
        rarity : 10,
        
    }
    
    var poison_red: EquipModel = "equip_poison_red";
    static var poison_red_data: EquipModelData = {
        model: poison_red,
        
        kind : Poison,
        
        stuck : true,
        
        rarity : 10,
        
    }
    
    var poison_white: EquipModel = "equip_poison_white";
    static var poison_white_data: EquipModelData = {
        model: poison_white,
        
        kind : Poison,
        
        stuck : true,
        
        rarity : 10,
        
    }
    
    var axe: EquipModel = "equip_axe";
    static var axe_data: EquipModelData = {
        model: axe,
        
        kind : Weapon,
        
        rarity : 3,
        
        minDropLevel : 1,
        
        maxDropLevel : 10,
        
        damage : [1,2,2,2,3,4],
        
        damageRange : [0,1,1,1,2,2,3],
        
        attFine : 1,
        
    }
    
    var dagger: EquipModel = "equip_dagger";
    static var dagger_data: EquipModelData = {
        model: dagger,
        
        kind : Weapon,
        
        rarity : 1,
        
        minDropLevel : 1,
        
        maxDropLevel : 10,
        
        damage : [1,1,2,2,3],
        
        damageRange : [0,1,1,2],
        
    }
    
    var staff: EquipModel = "equip_staff";
    static var staff_data: EquipModelData = {
        model: staff,
        
        kind : Weapon,
        
        rarity : 3,
        
        minDropLevel : 1,
        
        maxDropLevel : 10,
        
        damage : [1],
        
        damageRange : [0,1],
        
        attFine : 1,
        
        ability1 : ThrowSpell,
        
        spellDamage : [3],
        
        spellDamageRange : [0,1],
        
    }
    
    var sword: EquipModel = "equip_sword";
    static var sword_data: EquipModelData = {
        model: sword,
        
        kind : Weapon,
        
        rarity : 3,
        
        minDropLevel : 1,
        
        maxDropLevel : 10,
        
        damage : [1,2,2,2,3,4],
        
        damageRange : [0,1,1,1,2,2,3],
        
        attFine : 1,
        
    }
    

    static public function get(model: EquipModel): EquipModelData {
        return switch (model) {
            
            case EquipModel.poison_black: poison_black_data;
            
            case EquipModel.poison_blue: poison_blue_data;
            
            case EquipModel.poison_green: poison_green_data;
            
            case EquipModel.poison_red: poison_red_data;
            
            case EquipModel.poison_white: poison_white_data;
            
            case EquipModel.axe: axe_data;
            
            case EquipModel.dagger: dagger_data;
            
            case EquipModel.staff: staff_data;
            
            case EquipModel.sword: sword_data;
            
        }
    }

    
    static var _all: Array<{model: EquipModel, data: EquipModelData}> = [
        
        { model: poison_black, data: poison_black_data },
        
        { model: poison_blue, data: poison_blue_data },
        
        { model: poison_green, data: poison_green_data },
        
        { model: poison_red, data: poison_red_data },
        
        { model: poison_white, data: poison_white_data },
        
        { model: axe, data: axe_data },
        
        { model: dagger, data: dagger_data },
        
        { model: staff, data: staff_data },
        
        { model: sword, data: sword_data },
        
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