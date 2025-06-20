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

(declare-sort var581 0)
(declare-sort var2032 0)
(declare-sort var2158 0)
(declare-sort var3373 0)
(declare-sort var2464 0)
(declare-sort var713 0)
(declare-sort var1740 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2158_getMethodName/-888969971 (var2158) String)
(declare-fun addParameter/-1629709269 (var2032 String String) var2032)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getServiceKey/1456125852 (var2032) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun caches/-480735301 (var581) var3373)
(declare-fun var713_get/1088891777 (var713 var2464) var2464)
(declare-fun cast-from-var3373-to-var713 (var3373) var713)
(declare-fun cast-from-String-to-var2464 (String) var2464)
(declare-fun cast-from-var2464-to-var1740 (var2464) var1740)
(declare-const null-var581 var581)
(declare-const null-var2032 var2032)
(declare-const null-var2158 var2158)
(declare-const null-var1740 var1740)
(declare-const var1988 var581) ; Statement: r8 := @this: org.apache.dubbo.cache.support.AbstractCacheFactory 
(assert (not (= var1988 null-var581)))
(declare-const var267 var2032) ; Statement: r16 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var267 null-var2032)))
(declare-const var402 var2158) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var402 null-var2158)))
(define-const var288 String (var2158_getMethodName/-888969971 var402)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var3189 var2032 (addParameter/-1629709269 var267 "method" var288)) ; Statement: r17 = virtualinvoke r16.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("method", $r1) 
(define-const var607 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var607)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var607!1 String)
(assert (= var607!1 ""))
(assert true)
(define-const var1822 String (getServiceKey/1456125852 var3189)) ; Statement: $r3 = virtualinvoke r17.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var1080 String (append/672562846 var607!1 var1822)) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var607!2 String)
(assert (= var607!2 (str.++ var607!1 var1822)))
(define-const var1678 String (var2158_getMethodName/-888969971 var402)) ; Statement: $r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var3585 String (append/672562846 var1080 var1678)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1080!1 String)
(assert (= var1080!1 (str.++ var1080 var1678)))
(assert true)
(define-const var1981 String (toString/-2075883882 var3585)) ; Statement: r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var756 var3373 (caches/-480735301 var1988)) ; Statement: $r9 = r8.<org.apache.dubbo.cache.support.AbstractCacheFactory: java.util.concurrent.ConcurrentMap caches> 
(define-const var2164 var2464 (var713_get/1088891777 (cast-from-var3373-to-var713 var756) (cast-from-String-to-var2464 var1981))) ; Statement: $r10 = interfaceinvoke $r9.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r7) 
(define-const var3552 var1740 (cast-from-var2464-to-var1740 var2164)) ; Statement: r18 = (org.apache.dubbo.cache.Cache) $r10 
 ; Statement: if null == r18 goto $r11 = r8.<org.apache.dubbo.cache.support.AbstractCacheFactory: java.lang.Object MONITOR> 
(assert (not (= null-var1740 var3552))) ; Negate: Cond: null == r18  
 ; Statement: return r18 
(check-sat)
; {var2158_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), caches/-480735301=([org.apache.dubbo.cache.support.AbstractCacheFactory], java.util.concurrent.ConcurrentMap), var713_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var3373-to-var713=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var2464=([java.lang.String], java.lang.Object), cast-from-var2464-to-var1740=([java.lang.Object], org.apache.dubbo.cache.Cache)}
; {var581=org.apache.dubbo.cache.support.AbstractCacheFactory, var1988=r8, var2032=org.apache.dubbo.common.URL, var267=r16, var2158=org.apache.dubbo.rpc.Invocation, var402=r0, var288=$r1, var3189=r17, var607=$r2, var1822=$r3, var1080=$r5, var1678=$r4, var3585=$r6, var1981=r7, var3373=java.util.concurrent.ConcurrentMap, var756=$r9, var2464=java.lang.Object, var713=java.util.Map, var2164=$r10, var1740=org.apache.dubbo.cache.Cache, var3552=r18}
; {org.apache.dubbo.cache.support.AbstractCacheFactory=var581, r8=var1988, org.apache.dubbo.common.URL=var2032, r16=var267, org.apache.dubbo.rpc.Invocation=var2158, r0=var402, $r1=var288, r17=var3189, $r2=var607, $r3=var1822, $r5=var1080, $r4=var1678, $r6=var3585, r7=var1981, java.util.concurrent.ConcurrentMap=var3373, $r9=var756, java.lang.Object=var2464, java.util.Map=var713, $r10=var2164, org.apache.dubbo.cache.Cache=var1740, r18=var3552}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.cache.support.AbstractCacheFactory;	r16 := @parameter0: org.apache.dubbo.common.URL;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	r17 = virtualinvoke r16.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("method", $r1);	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke r17.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$r9 = r8.<org.apache.dubbo.cache.support.AbstractCacheFactory: java.util.concurrent.ConcurrentMap caches>;	$r10 = interfaceinvoke $r9.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r7);	r18 = (org.apache.dubbo.cache.Cache) $r10;	if null == r18 goto $r11 = r8.<org.apache.dubbo.cache.support.AbstractCacheFactory: java.lang.Object MONITOR>;	return r18
;block_num 2