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

(declare-sort var3037 0)
(declare-sort var3796 0)
(declare-sort var3846 0)
(declare-sort var2903 0)
(declare-sort var3785 0)
(declare-sort var1939 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/1193143623 (var2903) void)
(declare-fun cast-from-var3037-to-var2903 (var3037) var2903)
(declare-fun var3785_getSystemProperty/1393069448 (String) String)
(declare-fun var1939_isEmpty/-813097145 (String) Bool)
(declare-fun var1939_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var1939_parseInteger/495092342 (String) Int)
(declare-fun var1939_parseLong/1664390791 (String) Int)
(declare-fun init/-1133620791 (var2903 Bool String String Int Int Int var3846) void)
(declare-const null-var3037 var3037)
(declare-const null-Bool Bool)
(declare-const null-String String)
(declare-const null-var3846 var3846)
(declare-const var2044 var3037) ; Statement: r0 := @this: org.apache.dubbo.metadata.MappingCacheManager 
(assert (not (= var2044 null-var3037)))
(declare-const var3194 Bool) ; Statement: z2 := @parameter0: boolean 
(assert (not (= var3194 null-Bool)))
(declare-const var1687 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1687 null-String)))
(declare-const var338 var3846) ; Statement: r3 := @parameter2: java.util.concurrent.ScheduledExecutorService 
(assert (not (= var338 null-var3846)))
(assert true)
;(assert (<init>/1193143623 (cast-from-var3037-to-var2903 var2044))) ; Statement: specialinvoke r0.<org.apache.dubbo.metadata.AbstractCacheManager: void <init>()>() 

(declare-const var2044!1 var3037)
(define-const var2679 String (var3785_getSystemProperty/1393069448 "dubbo.mapping.cache.filePath")) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.filePath") 
(define-const var596 String (var3785_getSystemProperty/1393069448 "dubbo.mapping.cache.fileName")) ; Statement: r10 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.fileName") 
(define-const var1084 Bool (var1939_isEmpty/-813097145 var596)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
(assert (= (ite var1084 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2173 Bool (var1939_isNotEmpty/-1251449450 var1687)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.entrySize") 
(assert (= (ite var2173 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2698 String (var3785_getSystemProperty/1393069448 "dubbo.mapping.cache.entrySize")) ; Statement: $r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.entrySize") 
(define-const var697 Int (var1939_parseInteger/495092342 var2698)) ; Statement: $i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>($r9) 
 ; Statement: if $i1 != 0 goto $i2 = $i1 
(assert (not (not (= var697 0)))) ; Negate: Cond: $i1 != 0  
(define-const var3609 Int 10000) ; Statement: $i2 = 10000 
 ; Statement: goto [?= $r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.maxFileSize")] 
(assert true) ; Non Conditional
(define-const var1114 String (var3785_getSystemProperty/1393069448 "dubbo.mapping.cache.maxFileSize")) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.maxFileSize") 
(define-const var2239 Int (var1939_parseLong/1664390791 var1114)) ; Statement: $l0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>($r4) 
(assert true)
;(assert (init/-1133620791 (cast-from-var3037-to-var2903 var2044!1) var3194 var2679 var596 var3609 var2239 50 var338)) ; Statement: virtualinvoke r0.<org.apache.dubbo.metadata.MappingCacheManager: void init(boolean,java.lang.String,java.lang.String,int,long,int,java.util.concurrent.ScheduledExecutorService)>(z2, r1, r10, $i2, $l0, 50, r3) 

(declare-const var2044!2 var3037)
(declare-const var3194!1 Bool)
(declare-const var2679!1 String)
(declare-const var596!1 String)
(declare-const var3609!1 Int)
(declare-const var2239!1 Int)
(declare-const var1104 Int)
(declare-const var338!1 var3846)
 ; Statement: return 
(check-sat)
; {<init>/1193143623=([org.apache.dubbo.metadata.AbstractCacheManager], void), cast-from-var3037-to-var2903=([org.apache.dubbo.metadata.MappingCacheManager], org.apache.dubbo.metadata.AbstractCacheManager), var3785_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var1939_isEmpty/-813097145=([java.lang.String], boolean), var1939_isNotEmpty/-1251449450=([java.lang.String], boolean), var1939_parseInteger/495092342=([java.lang.String], int), var1939_parseLong/1664390791=([java.lang.String], long), init/-1133620791=([org.apache.dubbo.metadata.AbstractCacheManager, boolean, java.lang.String, java.lang.String, int, long, int, java.util.concurrent.ScheduledExecutorService], void)}
; {var3037=org.apache.dubbo.metadata.MappingCacheManager, var2044=r0, var3194=z2, var1687=r2, var3796=null_type, var3846=java.util.concurrent.ScheduledExecutorService, var338=r3, var2903=org.apache.dubbo.metadata.AbstractCacheManager, var3785=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2679=r1, var596=r10, var1939=org.apache.dubbo.common.utils.StringUtils, var1084=$z0, var2173=$z1, var2698=$r9, var697=$i1, var3609=$i2, var1114=$r4, var2239=$l0, var1104=50}
; {org.apache.dubbo.metadata.MappingCacheManager=var3037, r0=var2044, z2=var3194, r2=var1687, null_type=var3796, java.util.concurrent.ScheduledExecutorService=var3846, r3=var338, org.apache.dubbo.metadata.AbstractCacheManager=var2903, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var3785, r1=var2679, r10=var596, org.apache.dubbo.common.utils.StringUtils=var1939, $z0=var1084, $z1=var2173, $r9=var2698, $i1=var697, $i2=var3609, $r4=var1114, $l0=var2239, 50=var1104}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.MappingCacheManager;	z2 := @parameter0: boolean;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.util.concurrent.ScheduledExecutorService;	specialinvoke r0.<org.apache.dubbo.metadata.AbstractCacheManager: void <init>()>();	r1 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.filePath");	r10 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.fileName");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.entrySize");	$r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.entrySize");	$i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>($r9);	if $i1 != 0 goto $i2 = $i1;	$i2 = 10000;	goto [?= $r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.maxFileSize")];	$r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.mapping.cache.maxFileSize");	$l0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>($r4);	virtualinvoke r0.<org.apache.dubbo.metadata.MappingCacheManager: void init(boolean,java.lang.String,java.lang.String,int,long,int,java.util.concurrent.ScheduledExecutorService)>(z2, r1, r10, $i2, $l0, 50, r3);	return
;block_num 5