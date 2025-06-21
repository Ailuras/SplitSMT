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

(declare-sort var1878 0)
(declare-sort var2021 0)
(declare-sort var2104 0)
(declare-sort var447 0)
(declare-sort var661 0)
(declare-sort var1211 0)
(declare-sort var1948 0)
(declare-sort var2580 0)
(declare-sort var3437 0)
(declare-sort var2047 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun var2021-init () var2021)
(declare-fun <init>/-1681595970 (var2021 String) void)
(declare-fun toPath/-1698179320 (var2021) var2104)
(declare-fun isDirectory/-2122094196 (var2021) Bool)
(declare-fun var447_safeName/1752923487 (String) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1948_bootstrap$/-1662036292 (Bool) var1211)
(declare-fun var3437_computeIfAbsent/-1297680746 (var661 var2580 var1211) var2580)
(declare-fun cast-from-String-to-var2580 (String) var2580)
(declare-fun cast-from-var2580-to-var2047 (var2580) var2047)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var2021-separator String)
(declare-const var447-cacheMap var661)
(declare-const var2841 String) ; Statement: r31 := @parameter0: java.lang.String 
(assert (not (= var2841 null-String)))
(declare-const var3183 String) ; Statement: r32 := @parameter1: java.lang.String 
(assert (not (= var3183 null-String)))
(declare-const var399 Bool) ; Statement: z3 := @parameter2: boolean 
(assert (not (= var399 null-Bool)))
 ; Statement: if r31 != null goto $r0 = <java.io.File: java.lang.String separator> 
(assert (not (= var2841 null-String))) ; Cond: r31 != null 
(define-const var2443 String var2021-separator) ; Statement: $r0 = <java.io.File: java.lang.String separator> 
(assert true)
(define-const var2999 Bool (endsWith/985337093 var2841 var2443)) ; Statement: $z0 = virtualinvoke r31.<java.lang.String: boolean endsWith(java.lang.String)>($r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.io.File 
(assert (= (ite var2999 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1325 var2021 var2021-init) ; Statement: $r1 = new java.io.File 
(assert true)
;(assert (<init>/-1681595970 var1325 var2841)) ; Statement: specialinvoke $r1.<java.io.File: void <init>(java.lang.String)>(r31) 

(declare-const var1325!1 var2021)
(declare-const var2841!1 String)
(assert true)
(define-const var2551 var2104 (toPath/-1698179320 var1325!1)) ; Statement: $r17 = virtualinvoke $r1.<java.io.File: java.nio.file.Path toPath()>() 
(assert true)
(define-const var1871 Bool (isDirectory/-2122094196 var1325!1)) ; Statement: $z1 = virtualinvoke $r1.<java.io.File: boolean isDirectory()>() 
 ; Statement: if $z1 != 0 goto $r16 = staticinvoke <org.apache.dubbo.common.cache.FileCacheStoreFactory: java.lang.String safeName(java.lang.String)>(r32) 
(assert (not (= (ite var1871 1 0) 0))) ; Cond: $z1 != 0 
(define-const var2309 String (var447_safeName/1752923487 var3183)) ; Statement: $r16 = staticinvoke <org.apache.dubbo.common.cache.FileCacheStoreFactory: java.lang.String safeName(java.lang.String)>(r32) 
(define-const var813 String var2309) ; Statement: r33 = $r16 
(assert true)
(define-const var3480 Bool (endsWith/985337093 var2309 ".dubbo.cache")) ; Statement: $z2 = virtualinvoke $r16.<java.lang.String: boolean endsWith(java.lang.String)>(".dubbo.cache") 
 ; Statement: if $z2 != 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (= (ite var3480 1 0) 0))) ; Cond: $z2 != 0 
(define-const var1087 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1087)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1087!1 String)
(assert (= var1087!1 ""))
(assert true)
(define-const var1619 String (append/672562846 var1087!1 var2841!1)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r31) 
(declare-const var1087!2 String)
(assert (= var1087!2 (str.++ var1087!1 var2841!1)))
(define-const var3690 String var2021-separator) ; Statement: $r3 = <java.io.File: java.lang.String separator> 
(assert true)
(define-const var137 String (append/672562846 var1619 var3690)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1619!1 String)
(assert (= var1619!1 (str.++ var1619 var3690)))
(assert true)
(define-const var1842 String (append/672562846 var137 var813)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r33) 
(declare-const var137!1 String)
(assert (= var137!1 (str.++ var137 var813)))
(assert true)
(define-const var2367 String (toString/-2075883882 var1842)) ; Statement: $r14 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2455 var661 var447-cacheMap) ; Statement: $r7 = <org.apache.dubbo.common.cache.FileCacheStoreFactory: java.util.concurrent.ConcurrentMap cacheMap> 
(define-const var3494 var1211 (var1948_bootstrap$/-1662036292 var399)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.common.cache.FileCacheStoreFactory$lambda_getInstance_0__139: java.util.function.Function bootstrap$(boolean)>(z3) 
(define-const var1683 var2580 (var3437_computeIfAbsent/-1297680746 var2455 (cast-from-String-to-var2580 var2367) var3494)) ; Statement: $r9 = staticinvoke <org.apache.dubbo.common.utils.ConcurrentHashMapUtils: java.lang.Object computeIfAbsent(java.util.concurrent.ConcurrentMap,java.lang.Object,java.util.function.Function)>($r7, $r14, $r8) 
(define-const var3139 var2047 (cast-from-var2580-to-var2047 var1683)) ; Statement: $r10 = (org.apache.dubbo.common.cache.FileCacheStore) $r9 
 ; Statement: return $r10 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean), var2021-init=([], java.io.File), <init>/-1681595970=([java.io.File, java.lang.String], void), toPath/-1698179320=([java.io.File], java.nio.file.Path), isDirectory/-2122094196=([java.io.File], boolean), var447_safeName/1752923487=([java.lang.String], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1948_bootstrap$/-1662036292=([boolean], java.util.function.Function), var3437_computeIfAbsent/-1297680746=([java.util.concurrent.ConcurrentMap, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-String-to-var2580=([java.lang.String], java.lang.Object), cast-from-var2580-to-var2047=([java.lang.Object], org.apache.dubbo.common.cache.FileCacheStore)}
; {var2841=r31, var1878=null_type, var3183=r32, var399=z3, var2021=java.io.File, var2443=$r0, var2999=$z0, var1325=$r1, var2104=java.nio.file.Path, var2551=$r17, var1871=$z1, var447=org.apache.dubbo.common.cache.FileCacheStoreFactory, var2309=$r16, var813=r33, var3480=$z2, var1087=$r2, var1619=$r4, var3690=$r3, var137=$r5, var1842=$r6, var2367=$r14, var661=java.util.concurrent.ConcurrentMap, var2455=$r7, var1211=java.util.function.Function, var1948=org.apache.dubbo.common.cache.FileCacheStoreFactory$lambda_getInstance_0__139, var3494=$r8, var2580=java.lang.Object, var3437=org.apache.dubbo.common.utils.ConcurrentHashMapUtils, var1683=$r9, var2047=org.apache.dubbo.common.cache.FileCacheStore, var3139=$r10}
; {r31=var2841, null_type=var1878, r32=var3183, z3=var399, java.io.File=var2021, $r0=var2443, $z0=var2999, $r1=var1325, java.nio.file.Path=var2104, $r17=var2551, $z1=var1871, org.apache.dubbo.common.cache.FileCacheStoreFactory=var447, $r16=var2309, r33=var813, $z2=var3480, $r2=var1087, $r4=var1619, $r3=var3690, $r5=var137, $r6=var1842, $r14=var2367, java.util.concurrent.ConcurrentMap=var661, $r7=var2455, java.util.function.Function=var1211, org.apache.dubbo.common.cache.FileCacheStoreFactory$lambda_getInstance_0__139=var1948, $r8=var3494, java.lang.Object=var2580, org.apache.dubbo.common.utils.ConcurrentHashMapUtils=var3437, $r9=var1683, org.apache.dubbo.common.cache.FileCacheStore=var2047, $r10=var3139}
;seq <java.lang.String: boolean endsWith(java.lang.String)>;	<java.lang.String: boolean endsWith(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 2,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r31 := @parameter0: java.lang.String;	r32 := @parameter1: java.lang.String;	z3 := @parameter2: boolean;	if r31 != null goto $r0 = <java.io.File: java.lang.String separator>;	$r0 = <java.io.File: java.lang.String separator>;	$z0 = virtualinvoke r31.<java.lang.String: boolean endsWith(java.lang.String)>($r0);	if $z0 == 0 goto $r1 = new java.io.File;	$r1 = new java.io.File;	specialinvoke $r1.<java.io.File: void <init>(java.lang.String)>(r31);	$r17 = virtualinvoke $r1.<java.io.File: java.nio.file.Path toPath()>();	$z1 = virtualinvoke $r1.<java.io.File: boolean isDirectory()>();	if $z1 != 0 goto $r16 = staticinvoke <org.apache.dubbo.common.cache.FileCacheStoreFactory: java.lang.String safeName(java.lang.String)>(r32);	$r16 = staticinvoke <org.apache.dubbo.common.cache.FileCacheStoreFactory: java.lang.String safeName(java.lang.String)>(r32);	r33 = $r16;	$z2 = virtualinvoke $r16.<java.lang.String: boolean endsWith(java.lang.String)>(".dubbo.cache");	if $z2 != 0 goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r31);	$r3 = <java.io.File: java.lang.String separator>;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r33);	$r14 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = <org.apache.dubbo.common.cache.FileCacheStoreFactory: java.util.concurrent.ConcurrentMap cacheMap>;	$r8 = staticinvoke <org.apache.dubbo.common.cache.FileCacheStoreFactory$lambda_getInstance_0__139: java.util.function.Function bootstrap$(boolean)>(z3);	$r9 = staticinvoke <org.apache.dubbo.common.utils.ConcurrentHashMapUtils: java.lang.Object computeIfAbsent(java.util.concurrent.ConcurrentMap,java.lang.Object,java.util.function.Function)>($r7, $r14, $r8);	$r10 = (org.apache.dubbo.common.cache.FileCacheStore) $r9;	return $r10
;block_num 5