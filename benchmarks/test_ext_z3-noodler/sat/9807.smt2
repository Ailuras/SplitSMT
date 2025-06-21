(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2467 0)
(declare-sort var1110 0)
(declare-sort var1579 0)
(declare-sort var872 0)
(declare-sort var713 0)
(declare-sort var3217 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/1193143623 (var872) void)
(declare-fun cast-from-var2467-to-var872 (var2467) var872)
(declare-fun var713_getSystemProperty/1393069448 (String) String)
(declare-fun var3217_isEmpty/-813097145 (String) Bool)
(declare-fun var3217_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var3217_parseInteger/495092342 (String) Int)
(declare-fun var3217_parseLong/1664390791 (String) Int)
(declare-fun init/-1133620791 (var872 Bool String String Int Int Int var1579) void)
(declare-const null-var2467 var2467)
(declare-const null-Bool Bool)
(declare-const null-String String)
(declare-const null-var1579 var1579)
(declare-const var3752 var2467) ; Statement: r0 := @this: org.apache.dubbo.metadata.MappingCacheManager 
(assert (not (= var3752 null-var2467)))
(declare-const var3391 Bool) ; Statement: z2 := @parameter0: boolean 
(assert (not (= var3391 null-Bool)))
(declare-const var68 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var68 null-String)))
(declare-const var3379 var1579) ; Statement: r3 := @parameter2: java.util.concurrent.ScheduledExecutorService 
(assert (not (= var3379 null-var1579)))
(assert true)
;(assert (<init>/1193143623 (cast-from-var2467-to-var872 var3752))) ; Statement: specialinvoke r0.<org.apache.dubbo.metadata.AbstractCacheManager: void <init>()>() 

(declare-const var3752!1 var2467)
(define-const var2435 String (var713_getSystemProperty/1393069448 "dubbo.mapping.cache.filePath")) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.filePath") 
(define-const var1047 String (var713_getSystemProperty/1393069448 "dubbo.mapping.cache.fileName")) ; Statement: r10 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.fileName") 
(define-const var2055 Bool (var3217_isEmpty/-813097145 var1047)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
(assert (= (ite var2055 1 0) 0)) ; Cond: $z0 == 0 
(define-const var795 Bool (var3217_isNotEmpty/-1251449450 var68)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.entrySize") 
(assert (= (ite var795 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1277 String (var713_getSystemProperty/1393069448 "dubbo.mapping.cache.entrySize")) ; Statement: $r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.entrySize") 
(define-const var3203 Int (var3217_parseInteger/495092342 var1277)) ; Statement: $i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>($r9) 
 ; Statement: if $i1 != 0 goto $i2 = $i1 
(assert (not (= var3203 0))) ; Cond: $i1 != 0 
(define-const var2160 Int var3203) ; Statement: $i2 = $i1 
(assert true) ; Non Conditional
(define-const var227 String (var713_getSystemProperty/1393069448 "dubbo.mapping.cache.maxFileSize")) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.maxFileSize") 
(define-const var3532 Int (var3217_parseLong/1664390791 var227)) ; Statement: $l0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>($r4) 
(assert true)
;(assert (init/-1133620791 (cast-from-var2467-to-var872 var3752!1) var3391 var2435 var1047 var2160 var3532 50 var3379)) ; Statement: virtualinvoke r0.<org.apache.dubbo.metadata.MappingCacheManager: void init(boolean,java.lang.String,java.lang.String,int,long,int,java.util.concurrent.ScheduledExecutorService)>(z2, r1, r10, $i2, $l0, 50, r3) 

(declare-const var3752!2 var2467)
(declare-const var3391!1 Bool)
(declare-const var2435!1 String)
(declare-const var1047!1 String)
(declare-const var2160!1 Int)
(declare-const var3532!1 Int)
(declare-const var710 Int)
(declare-const var3379!1 var1579)
 ; Statement: return 
(check-sat)
; {<init>/1193143623=([org.apache.dubbo.metadata.AbstractCacheManager], void), cast-from-var2467-to-var872=([org.apache.dubbo.metadata.MappingCacheManager], org.apache.dubbo.metadata.AbstractCacheManager), var713_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var3217_isEmpty/-813097145=([java.lang.String], boolean), var3217_isNotEmpty/-1251449450=([java.lang.String], boolean), var3217_parseInteger/495092342=([java.lang.String], int), var3217_parseLong/1664390791=([java.lang.String], long), init/-1133620791=([org.apache.dubbo.metadata.AbstractCacheManager, boolean, java.lang.String, java.lang.String, int, long, int, java.util.concurrent.ScheduledExecutorService], void)}
; {var2467=org.apache.dubbo.metadata.MappingCacheManager, var3752=r0, var3391=z2, var68=r2, var1110=null_type, var1579=java.util.concurrent.ScheduledExecutorService, var3379=r3, var872=org.apache.dubbo.metadata.AbstractCacheManager, var713=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2435=r1, var1047=r10, var3217=org.apache.dubbo.common.utils.StringUtils, var2055=$z0, var795=$z1, var1277=$r9, var3203=$i1, var2160=$i2, var227=$r4, var3532=$l0, var710=50}
; {org.apache.dubbo.metadata.MappingCacheManager=var2467, r0=var3752, z2=var3391, r2=var68, null_type=var1110, java.util.concurrent.ScheduledExecutorService=var1579, r3=var3379, org.apache.dubbo.metadata.AbstractCacheManager=var872, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var713, r1=var2435, r10=var1047, org.apache.dubbo.common.utils.StringUtils=var3217, $z0=var2055, $z1=var795, $r9=var1277, $i1=var3203, $i2=var2160, $r4=var227, $l0=var3532, 50=var710}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.MappingCacheManager;	z2 := @parameter0: boolean;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.util.concurrent.ScheduledExecutorService;	specialinvoke r0.<org.apache.dubbo.metadata.AbstractCacheManager: void <init>()>();	r1 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.filePath");	r10 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.fileName");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.entrySize");	$r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.entrySize");	$i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>($r9);	if $i1 != 0 goto $i2 = $i1;	$i2 = $i1;	$r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.maxFileSize");	$l0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>($r4);	virtualinvoke r0.<org.apache.dubbo.metadata.MappingCacheManager: void init(boolean,java.lang.String,java.lang.String,int,long,int,java.util.concurrent.ScheduledExecutorService)>(z2, r1, r10, $i2, $l0, 50, r3);	return
;block_num 5