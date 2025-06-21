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

(declare-sort var1387 0)
(declare-sort var227 0)
(declare-sort var148 0)
(declare-sort var1676 0)
(declare-sort var2963 0)
(declare-sort var2641 0)
(declare-sort var3354 0)
(declare-sort var1827 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var148) void)
(declare-fun cast-from-var1387-to-var148 (var1387) var148)
(declare-fun getParameter/506106603 (var227 String String) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getAddress/-2093578336 (var227) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getServiceKey/1456125852 (var227) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getParameter/-1307325648 (var227 String) String)
(declare-fun var1676_isEmpty/-813097145 (String) Bool)
(declare-fun var2641_getCachingProvider/-1533966040 () var2963)
(declare-fun var2963_getCacheManager/-535745799 (var2963) var3354)
(declare-fun var3354_getCache/772535427 (var3354 String) var1827)
(declare-fun store/-881656675 (var1387) var1827)
(declare-const null-var1387 var1387)
(declare-const null-var227 var227)
(declare-const null-var1827 var1827)
(declare-const var1425 var1387) ; Statement: r0 := @this: org.apache.dubbo.cache.support.jcache.JCache 
(assert (not (= var1425 null-var1387)))
(declare-const var265 var227) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var265 null-var227)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1387-to-var148 var1425))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var1425!1 var1387)
(assert true)
(define-const var1509 String (getParameter/506106603 var265 "method" "")) ; Statement: r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("method", "") 
(define-const var1017 String String-init) ; Statement: $r27 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1017)) ; Statement: specialinvoke $r27.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1017!1 String)
(assert (= var1017!1 ""))
(assert true)
(define-const var1990 String (getAddress/-2093578336 var265)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(assert true)
(define-const var1068 String (append/672562846 var1017!1 var1990)) ; Statement: $r5 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1017!2 String)
(assert (= var1017!2 (str.++ var1017!1 var1990)))
(assert true)
(define-const var3554 String (append/672562846 var1068 ".")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var1068!1 String)
(assert (= var1068!1 (str.++ var1068 ".")))
(assert true)
(define-const var1844 String (getServiceKey/1456125852 var265)) ; Statement: $r6 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var3392 String (append/672562846 var3554 var1844)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3554!1 String)
(assert (= var3554!1 (str.++ var3554 var1844)))
(assert true)
(define-const var2926 String (append/672562846 var3392 ".")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3392!1 String)
(assert (= var3392!1 (str.++ var3392 ".")))
(assert true)
(define-const var1414 String (append/672562846 var2926 var1509)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2926!1 String)
(assert (= var2926!1 (str.++ var2926 var1509)))
(assert true)
(define-const var833 String (toString/-2075883882 var1414)) ; Statement: r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var1122 String (getParameter/-1307325648 var265 "jcache")) ; Statement: r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("jcache") 
(define-const var2987 Bool (var1676_isEmpty/-813097145 var1122)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r12) 
 ; Statement: if $z0 == 0 goto $r24 = staticinvoke <javax.cache.Caching: javax.cache.spi.CachingProvider getCachingProvider(java.lang.String)>(r12) 
(assert (not (= (ite var2987 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2169 var2963 var2641_getCachingProvider/-1533966040) ; Statement: $r24 = staticinvoke <javax.cache.Caching: javax.cache.spi.CachingProvider getCachingProvider()>() 
 ; Statement: goto [?= $r21 = interfaceinvoke $r24.<javax.cache.spi.CachingProvider: javax.cache.CacheManager getCacheManager()>()] 
(assert true) ; Non Conditional
(define-const var2763 var3354 (var2963_getCacheManager/-535745799 var2169)) ; Statement: $r21 = interfaceinvoke $r24.<javax.cache.spi.CachingProvider: javax.cache.CacheManager getCacheManager()>() 
(define-const var1345 var1827 (var3354_getCache/772535427 var2763 var833)) ; Statement: $r22 = interfaceinvoke $r21.<javax.cache.CacheManager: javax.cache.Cache getCache(java.lang.String)>(r11) 
(define-const var1470 var1827 var1345) ; Statement: r25 = $r22 
 ; Statement: if $r22 != null goto r0.<org.apache.dubbo.cache.support.jcache.JCache: javax.cache.Cache store> = r25 
(assert (not (= var1345 null-var1827))) ; Cond: $r22 != null 
(declare-const var1425!2 var1387)
(assert (not (= var1425!2 null-var1387)))
(assert (= (store/-881656675 var1425!2) var1470)) ; Statement: r0.<org.apache.dubbo.cache.support.jcache.JCache: javax.cache.Cache store> = r25 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1387-to-var148=([org.apache.dubbo.cache.support.jcache.JCache], java.lang.Object), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1676_isEmpty/-813097145=([java.lang.String], boolean), var2641_getCachingProvider/-1533966040=([], javax.cache.spi.CachingProvider), var2963_getCacheManager/-535745799=([javax.cache.spi.CachingProvider], javax.cache.CacheManager), var3354_getCache/772535427=([javax.cache.CacheManager, java.lang.String], javax.cache.Cache), store/-881656675=([org.apache.dubbo.cache.support.jcache.JCache], javax.cache.Cache)}
; {var1387=org.apache.dubbo.cache.support.jcache.JCache, var1425=r0, var227=org.apache.dubbo.common.URL, var265=r1, var148=java.lang.Object, var1509=r2, var1017=$r27, var1990=$r4, var1068=$r5, var3554=$r7, var1844=$r6, var3392=$r8, var2926=$r9, var1414=$r10, var833=r11, var1122=r12, var1676=org.apache.dubbo.common.utils.StringUtils, var2987=$z0, var2963=javax.cache.spi.CachingProvider, var2641=javax.cache.Caching, var2169=$r24, var3354=javax.cache.CacheManager, var2763=$r21, var1827=javax.cache.Cache, var1345=$r22, var1470=r25}
; {org.apache.dubbo.cache.support.jcache.JCache=var1387, r0=var1425, org.apache.dubbo.common.URL=var227, r1=var265, java.lang.Object=var148, r2=var1509, $r27=var1017, $r4=var1990, $r5=var1068, $r7=var3554, $r6=var1844, $r8=var3392, $r9=var2926, $r10=var1414, r11=var833, r12=var1122, org.apache.dubbo.common.utils.StringUtils=var1676, $z0=var2987, javax.cache.spi.CachingProvider=var2963, javax.cache.Caching=var2641, $r24=var2169, javax.cache.CacheManager=var3354, $r21=var2763, javax.cache.Cache=var1827, $r22=var1345, r25=var1470}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.cache.support.jcache.JCache;	r1 := @parameter0: org.apache.dubbo.common.URL;	specialinvoke r0.<java.lang.Object: void <init>()>();	r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("method", "");	$r27 = new java.lang.StringBuilder;	specialinvoke $r27.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r5 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r6 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("jcache");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r12);	if $z0 == 0 goto $r24 = staticinvoke <javax.cache.Caching: javax.cache.spi.CachingProvider getCachingProvider(java.lang.String)>(r12);	$r24 = staticinvoke <javax.cache.Caching: javax.cache.spi.CachingProvider getCachingProvider()>();	goto [?= $r21 = interfaceinvoke $r24.<javax.cache.spi.CachingProvider: javax.cache.CacheManager getCacheManager()>()];	$r21 = interfaceinvoke $r24.<javax.cache.spi.CachingProvider: javax.cache.CacheManager getCacheManager()>();	$r22 = interfaceinvoke $r21.<javax.cache.CacheManager: javax.cache.Cache getCache(java.lang.String)>(r11);	r25 = $r22;	if $r22 != null goto r0.<org.apache.dubbo.cache.support.jcache.JCache: javax.cache.Cache store> = r25;	r0.<org.apache.dubbo.cache.support.jcache.JCache: javax.cache.Cache store> = r25;	return
;block_num 4