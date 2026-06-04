#modloaded botania
#loader mixin
#priority 100

import native.net.minecraft.entity.monster.EntityCaveSpider;
import native.net.minecraft.entity.monster.EntityCreeper;
import native.net.minecraft.entity.monster.EntityEnderman;
import native.net.minecraft.entity.monster.EntityEvoker;
import native.net.minecraft.entity.monster.EntityHusk;
import native.net.minecraft.entity.monster.EntityMob;
import native.net.minecraft.entity.monster.EntitySkeleton;
import native.net.minecraft.entity.monster.EntitySpider;
import native.net.minecraft.entity.monster.EntityStray;
import native.net.minecraft.entity.monster.EntityVindicator;
import native.net.minecraft.entity.monster.EntityZombie;
import native.net.minecraft.world.World;

zenClass LooniumMobEntry {
    val mob as function(World)EntityMob;

    zenConstructor(mob as function(World)EntityMob) {
      this.mob = mob;
    }

    function getMob(world as World) as EntityMob {
        return this.mob(world);
    } 
}

static mobList as [LooniumMobEntry] = [
    LooniumMobEntry(function(w as World) as EntityMob { return EntityZombie(w);     }),
    LooniumMobEntry(function(w as World) as EntityMob { return EntitySkeleton(w);   }),
    LooniumMobEntry(function(w as World) as EntityMob { return EntityCreeper(w);    }),
    LooniumMobEntry(function(w as World) as EntityMob { return EntitySpider(w);     }),
    LooniumMobEntry(function(w as World) as EntityMob { return EntityCaveSpider(w); }),
    LooniumMobEntry(function(w as World) as EntityMob { return EntityEnderman(w);   }),
    LooniumMobEntry(function(w as World) as EntityMob { return EntityHusk(w);       }),
    LooniumMobEntry(function(w as World) as EntityMob { return EntityStray(w);      }),
    LooniumMobEntry(function(w as World) as EntityMob { return EntityEvoker(w);     }),
    LooniumMobEntry(function(w as World) as EntityMob { return EntityVindicator(w); }),
] as [LooniumMobEntry];
