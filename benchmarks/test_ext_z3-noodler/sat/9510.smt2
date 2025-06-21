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

(declare-sort var3907 0)
(declare-sort var3195 0)
(declare-sort var1365 0)
(declare-sort var3700 0)
(declare-sort var2842 0)
(declare-sort var1952 0)
(declare-sort var1346 0)
(declare-sort var743 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1365) void)
(declare-fun cast-from-var3907-to-var1365 (var3907) var1365)
(declare-fun getParameter/506106603 (var3195 String String) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getAddress/-2093578336 (var3195) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getServiceKey/1456125852 (var3195) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getParameter/-1307325648 (var3195 String) String)
(declare-fun var3700_isEmpty/-813097145 (String) Bool)
(declare-fun var1952_getCachingProvider/1358132301 (String) var2842)
(declare-fun var2842_getCacheManager/-535745799 (var2842) var1346)
(declare-fun var1346_getCache/772535427 (var1346 String) var743)
(declare-fun store/-881656675 (var3907) var743)
(declare-const null-var3907 var3907)
(declare-const null-var3195 var3195)
(declare-const null-var743 var743)
(declare-const var2813 var3907) ; Statement: r0 := @this: org.apache.dubbo.cache.support.jcache.JCache 
(assert (not (= var2813 null-var3907)))
(declare-const var1681 var3195) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1681 null-var3195)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3907-to-var1365 var2813))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2813!1 var3907)
(assert true)
(define-const var1296 String (getParameter/506106603 var1681 "method" "")) ; Statement: r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("method", "") 
(define-const var1768 String String-init) ; Statement: $r27 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1768)) ; Statement: specialinvoke $r27.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1768!1 String)
(assert (= var1768!1 ""))
(assert true)
(define-const var3757 String (getAddress/-2093578336 var1681)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(assert true)
(define-const var2836 String (append/672562846 var1768!1 var3757)) ; Statement: $r5 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1768!2 String)
(assert (= var1768!2 (str.++ var1768!1 var3757)))
(assert true)
(define-const var477 String (append/672562846 var2836 ".")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var2836!1 String)
(assert (= var2836!1 (str.++ var2836 ".")))
(assert true)
(define-const var3662 String (getServiceKey/1456125852 var1681)) ; Statement: $r6 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var3676 String (append/672562846 var477 var3662)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var477!1 String)
(assert (= var477!1 (str.++ var477 var3662)))
(assert true)
(define-const var2355 String (append/672562846 var3676 ".")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3676!1 String)
(assert (= var3676!1 (str.++ var3676 ".")))
(assert true)
(define-const var955 String (append/672562846 var2355 var1296)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2355!1 String)
(assert (= var2355!1 (str.++ var2355 var1296)))
(assert true)
(define-const var2025 String (toString/-2075883882 var955)) ; Statement: r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var317 String (getParameter/-1307325648 var1681 "jcache")) ; Statement: r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("jcache") 
(define-const var2574 Bool (var3700_isEmpty/-813097145 var317)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r12) 
 ; Statement: if $z0 == 0 goto $r24 = staticinvoke <javax.cache.Caching: javax.cache.spi.CachingProvider getCachingProvider(java.lang.String)>(r12) 
(assert (= (ite var2574 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3154 var2842 (var1952_getCachingProvider/1358132301 var317)) ; Statement: $r24 = staticinvoke <javax.cache.Caching: javax.cache.spi.CachingProvider getCachingProvider(java.lang.String)>(r12) 
(assert true) ; Non Conditional
(define-const var1637 var1346 (var2842_getCacheManager/-535745799 var3154)) ; Statement: $r21 = interfaceinvoke $r24.<javax.cache.spi.CachingProvider: javax.cache.CacheManager getCacheManager()>() 
(define-const var2439 var743 (var1346_getCache/772535427 var1637 var2025)) ; Statement: $r22 = interfaceinvoke $r21.<javax.cache.CacheManager: javax.cache.Cache getCache(java.lang.String)>(r11) 
(define-const var1563 var743 var2439) ; Statement: r25 = $r22 
 ; Statement: if $r22 != null goto r0.<org.apache.dubbo.cache.support.jcache.JCache: javax.cache.Cache store> = r25 
(assert (not (= var2439 null-var743))) ; Cond: $r22 != null 
(declare-const var2813!2 var3907)
(assert (not (= var2813!2 null-var3907)))
(assert (= (store/-881656675 var2813!2) var1563)) ; Statement: r0.<org.apache.dubbo.cache.support.jcache.JCache: javax.cache.Cache store> = r25 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3907-to-var1365=([org.apache.dubbo.cache.support.jcache.JCache], java.lang.Object), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3700_isEmpty/-813097145=([java.lang.String], boolean), var1952_getCachingProvider/1358132301=([java.lang.String], javax.cache.spi.CachingProvider), var2842_getCacheManager/-535745799=([javax.cache.spi.CachingProvider], javax.cache.CacheManager), var1346_getCache/772535427=([javax.cache.CacheManager, java.lang.String], javax.cache.Cache), store/-881656675=([org.apache.dubbo.cache.support.jcache.JCache], javax.cache.Cache)}
; {var3907=org.apache.dubbo.cache.support.jcache.JCache, var2813=r0, var3195=org.apache.dubbo.common.URL, var1681=r1, var1365=java.lang.Object, var1296=r2, var1768=$r27, var3757=$r4, var2836=$r5, var477=$r7, var3662=$r6, var3676=$r8, var2355=$r9, var955=$r10, var2025=r11, var317=r12, var3700=org.apache.dubbo.common.utils.StringUtils, var2574=$z0, var2842=javax.cache.spi.CachingProvider, var1952=javax.cache.Caching, var3154=$r24, var1346=javax.cache.CacheManager, var1637=$r21, var743=javax.cache.Cache, var2439=$r22, var1563=r25}
; {org.apache.dubbo.cache.support.jcache.JCache=var3907, r0=var2813, org.apache.dubbo.common.URL=var3195, r1=var1681, java.lang.Object=var1365, r2=var1296, $r27=var1768, $r4=var3757, $r5=var2836, $r7=var477, $r6=var3662, $r8=var3676, $r9=var2355, $r10=var955, r11=var2025, r12=var317, org.apache.dubbo.common.utils.StringUtils=var3700, $z0=var2574, javax.cache.spi.CachingProvider=var2842, javax.cache.Caching=var1952, $r24=var3154, javax.cache.CacheManager=var1346, $r21=var1637, javax.cache.Cache=var743, $r22=var2439, r25=var1563}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.cache.support.jcache.JCache;	r1 := @parameter0: org.apache.dubbo.common.URL;	specialinvoke r0.<java.lang.Object: void <init>()>();	r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("method", "");	$r27 = new java.lang.StringBuilder;	specialinvoke $r27.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r5 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r6 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("jcache");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r12);	if $z0 == 0 goto $r24 = staticinvoke <javax.cache.Caching: javax.cache.spi.CachingProvider getCachingProvider(java.lang.String)>(r12);	$r24 = staticinvoke <javax.cache.Caching: javax.cache.spi.CachingProvider getCachingProvider(java.lang.String)>(r12);	$r21 = interfaceinvoke $r24.<javax.cache.spi.CachingProvider: javax.cache.CacheManager getCacheManager()>();	$r22 = interfaceinvoke $r21.<javax.cache.CacheManager: javax.cache.Cache getCache(java.lang.String)>(r11);	r25 = $r22;	if $r22 != null goto r0.<org.apache.dubbo.cache.support.jcache.JCache: javax.cache.Cache store> = r25;	r0.<org.apache.dubbo.cache.support.jcache.JCache: javax.cache.Cache store> = r25;	return
;block_num 4