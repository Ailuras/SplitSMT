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

(declare-sort var1202 0)
(declare-sort var3339 0)
(declare-sort var1922 0)
(declare-sort var543 0)
(declare-sort var190 0)
(declare-sort var602 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/1193143623 (var543) void)
(declare-fun cast-from-var1202-to-var543 (var1202) var543)
(declare-fun var190_getSystemProperty/1393069448 (String) String)
(declare-fun var602_isEmpty/-813097145 (String) Bool)
(declare-fun var602_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var602_parseInteger/495092342 (String) Int)
(declare-fun var602_parseLong/1664390791 (String) Int)
(declare-fun init/-1133620791 (var543 Bool String String Int Int Int var1922) void)
(declare-const null-var1202 var1202)
(declare-const null-Bool Bool)
(declare-const null-String String)
(declare-const null-var1922 var1922)
(declare-const var1458 var1202) ; Statement: r0 := @this: org.apache.dubbo.registry.client.metadata.store.MetaCacheManager 
(assert (not (= var1458 null-var1202)))
(declare-const var1012 Bool) ; Statement: z2 := @parameter0: boolean 
(assert (not (= var1012 null-Bool)))
(declare-const var218 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var218 null-String)))
(declare-const var2181 var1922) ; Statement: r3 := @parameter2: java.util.concurrent.ScheduledExecutorService 
(assert (not (= var2181 null-var1922)))
(assert true)
;(assert (<init>/1193143623 (cast-from-var1202-to-var543 var1458))) ; Statement: specialinvoke r0.<org.apache.dubbo.metadata.AbstractCacheManager: void <init>()>() 

(declare-const var1458!1 var1202)
(define-const var2658 String (var190_getSystemProperty/1393069448 "dubbo.meta.cache.filePath")) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.filePath") 
(define-const var3907 String (var190_getSystemProperty/1393069448 "dubbo.meta.cache.fileName")) ; Statement: r10 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.fileName") 
(define-const var3428 Bool (var602_isEmpty/-813097145 var3907)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
(assert (= (ite var3428 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3418 Bool (var602_isNotEmpty/-1251449450 var218)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.entrySize") 
(assert (= (ite var3418 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3118 String (var190_getSystemProperty/1393069448 "dubbo.meta.cache.entrySize")) ; Statement: $r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.entrySize") 
(define-const var3903 Int (var602_parseInteger/495092342 var3118)) ; Statement: $i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>($r9) 
 ; Statement: if $i1 != 0 goto $i2 = $i1 
(assert (not (not (= var3903 0)))) ; Negate: Cond: $i1 != 0  
(define-const var551 Int 100) ; Statement: $i2 = 100 
 ; Statement: goto [?= $r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.maxFileSize")] 
(assert true) ; Non Conditional
(define-const var2156 String (var190_getSystemProperty/1393069448 "dubbo.meta.cache.maxFileSize")) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.maxFileSize") 
(define-const var3224 Int (var602_parseLong/1664390791 var2156)) ; Statement: $l0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>($r4) 
(assert true)
;(assert (init/-1133620791 (cast-from-var1202-to-var543 var1458!1) var1012 var2658 var3907 var551 var3224 60 var2181)) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.client.metadata.store.MetaCacheManager: void init(boolean,java.lang.String,java.lang.String,int,long,int,java.util.concurrent.ScheduledExecutorService)>(z2, r1, r10, $i2, $l0, 60, r3) 

(declare-const var1458!2 var1202)
(declare-const var1012!1 Bool)
(declare-const var2658!1 String)
(declare-const var3907!1 String)
(declare-const var551!1 Int)
(declare-const var3224!1 Int)
(declare-const var916 Int)
(declare-const var2181!1 var1922)
 ; Statement: return 
(check-sat)
; {<init>/1193143623=([org.apache.dubbo.metadata.AbstractCacheManager], void), cast-from-var1202-to-var543=([org.apache.dubbo.registry.client.metadata.store.MetaCacheManager], org.apache.dubbo.metadata.AbstractCacheManager), var190_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var602_isEmpty/-813097145=([java.lang.String], boolean), var602_isNotEmpty/-1251449450=([java.lang.String], boolean), var602_parseInteger/495092342=([java.lang.String], int), var602_parseLong/1664390791=([java.lang.String], long), init/-1133620791=([org.apache.dubbo.metadata.AbstractCacheManager, boolean, java.lang.String, java.lang.String, int, long, int, java.util.concurrent.ScheduledExecutorService], void)}
; {var1202=org.apache.dubbo.registry.client.metadata.store.MetaCacheManager, var1458=r0, var1012=z2, var218=r2, var3339=null_type, var1922=java.util.concurrent.ScheduledExecutorService, var2181=r3, var543=org.apache.dubbo.metadata.AbstractCacheManager, var190=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2658=r1, var3907=r10, var602=org.apache.dubbo.common.utils.StringUtils, var3428=$z0, var3418=$z1, var3118=$r9, var3903=$i1, var551=$i2, var2156=$r4, var3224=$l0, var916=60}
; {org.apache.dubbo.registry.client.metadata.store.MetaCacheManager=var1202, r0=var1458, z2=var1012, r2=var218, null_type=var3339, java.util.concurrent.ScheduledExecutorService=var1922, r3=var2181, org.apache.dubbo.metadata.AbstractCacheManager=var543, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var190, r1=var2658, r10=var3907, org.apache.dubbo.common.utils.StringUtils=var602, $z0=var3428, $z1=var3418, $r9=var3118, $i1=var3903, $i2=var551, $r4=var2156, $l0=var3224, 60=var916}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.metadata.store.MetaCacheManager;	z2 := @parameter0: boolean;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.util.concurrent.ScheduledExecutorService;	specialinvoke r0.<org.apache.dubbo.metadata.AbstractCacheManager: void <init>()>();	r1 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.filePath");	r10 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.fileName");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.entrySize");	$r9 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.entrySize");	$i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int parseInteger(java.lang.String)>($r9);	if $i1 != 0 goto $i2 = $i1;	$i2 = 100;	goto [?= $r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.maxFileSize")];	$r4 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.meta.cache.maxFileSize");	$l0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: long parseLong(java.lang.String)>($r4);	virtualinvoke r0.<org.apache.dubbo.registry.client.metadata.store.MetaCacheManager: void init(boolean,java.lang.String,java.lang.String,int,long,int,java.util.concurrent.ScheduledExecutorService)>(z2, r1, r10, $i2, $l0, 60, r3);	return
;block_num 5