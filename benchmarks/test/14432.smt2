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

(declare-sort var1323 0)
(declare-sort var1366 0)
(declare-sort var1896 0)
(declare-sort var1548 0)
(declare-sort var3380 0)
(declare-sort var834 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/1193143623 (var1548) void)
(declare-fun cast-from-var1323-to-var1548 (var1323) var1548)
(declare-fun var3380_getSystemProperty/1393069448 (String) String)
(declare-fun var834_isEmpty/-813097145 (String) Bool)
(declare-fun var834_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var834_parseInteger/495092342 (String) Int)
(declare-fun var834_parseLong/1664390791 (String) Int)
(declare-fun init/-1133620791 (var1548 Bool String String Int Int Int var1896) void)
(declare-const null-var1323 var1323)
(declare-const null-Bool Bool)
(declare-const null-String String)
(declare-const null-var1896 var1896)
(declare-const var995 var1323) ; Statement: r0 := @this: org.apache.dubbo.registry.client.metadata.store.MetaCacheManager 
(assert (not (= var995 null-var1323)))
(declare-const var236 Bool) ; Statement: z2 := @parameter0: boolean 
(assert (not (= var236 null-Bool)))
(declare-const var1732 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1732 null-String)))
(declare-const var2380 var1896) ; Statement: r3 := @parameter2: java.util.concurrent.ScheduledExecutorService 
(assert (not (= var2380 null-var1896)))
(assert true)
;(assert (<init>/1193143623 (cast-from-var1323-to-var1548 var995))) ; Statement: specialinvoke r0.<org.apache.dubbo.metadata.AbstractCacheManager: void <init>()>() 

(declare-const var995!1 var1323)
(define-const var379 String (var3380_getSystemProperty/1393069448 "dubbo.meta.cache.filePath")) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.filePath") 
(define-const var1926 String (var3380_getSystemProperty/1393069448 "dubbo.meta.cache.fileName")) ; Statement: r10 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.fileName") 
(define-const var513 Bool (var834_isEmpty/-813097145 var1926)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
(assert (= (ite var513 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3415 Bool (var834_isNotEmpty/-1251449450 var1732)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.entrySize") 
(assert (= (ite var3415 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1588 String (var3380_getSystemProperty/1393069448 "dubbo.meta.cache.entrySize")) ; Statement: $r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.entrySize") 
(define-const var1769 Int (var834_parseInteger/495092342 var1588)) ; Statement: $i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>($r9) 
 ; Statement: if $i1 != 0 goto $i2 = $i1 
(assert (not (= var1769 0))) ; Cond: $i1 != 0 
(define-const var2579 Int var1769) ; Statement: $i2 = $i1 
(assert true) ; Non Conditional
(define-const var359 String (var3380_getSystemProperty/1393069448 "dubbo.meta.cache.maxFileSize")) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.maxFileSize") 
(define-const var3541 Int (var834_parseLong/1664390791 var359)) ; Statement: $l0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>($r4) 
(assert true)
;(assert (init/-1133620791 (cast-from-var1323-to-var1548 var995!1) var236 var379 var1926 var2579 var3541 60 var2380)) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.client.metadata.store.MetaCacheManager: void init(boolean,java.lang.String,java.lang.String,int,long,int,java.util.concurrent.ScheduledExecutorService)>(z2, r1, r10, $i2, $l0, 60, r3) 

(declare-const var995!2 var1323)
(declare-const var236!1 Bool)
(declare-const var379!1 String)
(declare-const var1926!1 String)
(declare-const var2579!1 Int)
(declare-const var3541!1 Int)
(declare-const var1432 Int)
(declare-const var2380!1 var1896)
 ; Statement: return 
(check-sat)
; {<init>/1193143623=([org.apache.dubbo.metadata.AbstractCacheManager], void), cast-from-var1323-to-var1548=([org.apache.dubbo.registry.client.metadata.store.MetaCacheManager], org.apache.dubbo.metadata.AbstractCacheManager), var3380_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var834_isEmpty/-813097145=([java.lang.String], boolean), var834_isNotEmpty/-1251449450=([java.lang.String], boolean), var834_parseInteger/495092342=([java.lang.String], int), var834_parseLong/1664390791=([java.lang.String], long), init/-1133620791=([org.apache.dubbo.metadata.AbstractCacheManager, boolean, java.lang.String, java.lang.String, int, long, int, java.util.concurrent.ScheduledExecutorService], void)}
; {var1323=org.apache.dubbo.registry.client.metadata.store.MetaCacheManager, var995=r0, var236=z2, var1732=r2, var1366=null_type, var1896=java.util.concurrent.ScheduledExecutorService, var2380=r3, var1548=org.apache.dubbo.metadata.AbstractCacheManager, var3380=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var379=r1, var1926=r10, var834=org.apache.dubbo.common.utils.StringUtils, var513=$z0, var3415=$z1, var1588=$r9, var1769=$i1, var2579=$i2, var359=$r4, var3541=$l0, var1432=60}
; {org.apache.dubbo.registry.client.metadata.store.MetaCacheManager=var1323, r0=var995, z2=var236, r2=var1732, null_type=var1366, java.util.concurrent.ScheduledExecutorService=var1896, r3=var2380, org.apache.dubbo.metadata.AbstractCacheManager=var1548, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var3380, r1=var379, r10=var1926, org.apache.dubbo.common.utils.StringUtils=var834, $z0=var513, $z1=var3415, $r9=var1588, $i1=var1769, $i2=var2579, $r4=var359, $l0=var3541, 60=var1432}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.metadata.store.MetaCacheManager;	z2 := @parameter0: boolean;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.util.concurrent.ScheduledExecutorService;	specialinvoke r0.<org.apache.dubbo.metadata.AbstractCacheManager: void <init>()>();	r1 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.filePath");	r10 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.fileName");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.entrySize");	$r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.entrySize");	$i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>($r9);	if $i1 != 0 goto $i2 = $i1;	$i2 = $i1;	$r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.maxFileSize");	$l0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>($r4);	virtualinvoke r0.<org.apache.dubbo.registry.client.metadata.store.MetaCacheManager: void init(boolean,java.lang.String,java.lang.String,int,long,int,java.util.concurrent.ScheduledExecutorService)>(z2, r1, r10, $i2, $l0, 60, r3);	return
;block_num 5