(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3840 0)
(declare-sort var197 0)
(declare-sort var572 0)
(declare-sort var3040 0)
(declare-sort var3307 0)
(declare-sort var1299 0)
(declare-sort var2967 0)
(declare-sort var160 0)
(declare-sort var1952 0)
(declare-sort var505 0)
(declare-sort var2490 0)
(declare-sort var3847 0)
(declare-sort var3731 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getClass/1258963082 (var197) ClassObject)
(declare-fun cast-from-var3840-to-var197 (var3840) var197)
(declare-fun getClassLoader/-563698447 (ClassObject) var572)
(declare-fun var3307_getRuntimeMXBean/1065218510 () var3040)
(declare-fun var3040_getClassPath/-494455271 (var3040) String)
(declare-fun var2967_of/184955601 ((Array Int var197)) var2967)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var197__ ((Array Int String)) (Array Int var197))
(declare-fun var1952_bootstrap$/-330321486 (var3840) var160)
(declare-fun var2967_map/130902797 (var2967 var160) var2967)
(declare-fun var2490_bootstrap$/-1486549636 () var505)
(declare-fun var2967_toArray/-73424125 (var2967 var505) (Array Int var197))
(declare-fun cast-from-__Array__Int__var197__-to-__Array__Int__var3847__ ((Array Int var197)) (Array Int var3847))
(declare-fun getUrlsFrom/1874242854 (var3840 (Array Int var3847)) var3731)
(declare-const null-var3840 var3840)
(declare-const var1299-pathSeparator String)
(declare-const var1266 var3840) ; Statement: r0 := @this: org.springframework.boot.web.servlet.server.StaticResourceJars 
(assert (not (= var1266 null-var3840)))
(assert true)
(define-const var3429 ClassObject (getClass/1258963082 (cast-from-var3840-to-var197 var1266))) ; Statement: $r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1495 var572 (getClassLoader/-563698447 var3429)) ; Statement: r2 = virtualinvoke $r1.<java.lang.Class: java.lang.ClassLoader getClassLoader()>() 
(define-const var2301 Bool false) ; Statement: $z0 = r2 instanceof java.net.URLClassLoader 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <java.lang.management.ManagementFactory: java.lang.management.RuntimeMXBean getRuntimeMXBean()>() 
(assert (= (ite var2301 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1903 var3040 var3307_getRuntimeMXBean/1065218510) ; Statement: $r3 = staticinvoke <java.lang.management.ManagementFactory: java.lang.management.RuntimeMXBean getRuntimeMXBean()>() 
(define-const var3718 String (var3040_getClassPath/-494455271 var1903)) ; Statement: $r5 = interfaceinvoke $r3.<java.lang.management.RuntimeMXBean: java.lang.String getClassPath()>() 
(define-const var3694 String var1299-pathSeparator) ; Statement: $r4 = <java.io.File: java.lang.String pathSeparator> 
; split operation: var3226 = var3718.split(var3694) ; Statement: $r6 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>($r4) 
(define-const var741 var2967 (var2967_of/184955601 (cast-from-__Array__Int__String__-to-__Array__Int__var197__ var3226))) ; Statement: $r8 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r6) 
(define-const var1979 var160 (var1952_bootstrap$/-330321486 var1266)) ; Statement: $r7 = staticinvoke <org.springframework.boot.web.servlet.server.StaticResourceJars$toUrl__788: java.util.function.Function bootstrap$(org.springframework.boot.web.servlet.server.StaticResourceJars)>(r0) 
(define-const var2647 var2967 (var2967_map/130902797 var741 var1979)) ; Statement: $r10 = interfaceinvoke $r8.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r7) 
(define-const var1021 var505 var2490_bootstrap$/-1486549636) ; Statement: $r9 = staticinvoke <org.springframework.boot.web.servlet.server.StaticResourceJars$lambda_getUrls_0__794: java.util.function.IntFunction bootstrap$()>() 
(define-const var3942 (Array Int var197) (var2967_toArray/-73424125 var2647 var1021)) ; Statement: $r11 = interfaceinvoke $r10.<java.util.stream.Stream: java.lang.Object[] toArray(java.util.function.IntFunction)>($r9) 
(define-const var2840 (Array Int var3847) (cast-from-__Array__Int__var197__-to-__Array__Int__var3847__ var3942)) ; Statement: $r12 = (java.net.URL[]) $r11 
(assert true)
(define-const var2190 var3731 (getUrlsFrom/1874242854 var1266 var2840)) ; Statement: $r13 = virtualinvoke r0.<org.springframework.boot.web.servlet.server.StaticResourceJars: java.util.List getUrlsFrom(java.net.URL[])>($r12) 
 ; Statement: return $r13 
(check-sat)
; {getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3840-to-var197=([org.springframework.boot.web.servlet.server.StaticResourceJars], java.lang.Object), getClassLoader/-563698447=([java.lang.Class], java.lang.ClassLoader), var3307_getRuntimeMXBean/1065218510=([], java.lang.management.RuntimeMXBean), var3040_getClassPath/-494455271=([java.lang.management.RuntimeMXBean], java.lang.String), var2967_of/184955601=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var197__=([java.lang.String[]], java.lang.Object[]), var1952_bootstrap$/-330321486=([org.springframework.boot.web.servlet.server.StaticResourceJars], java.util.function.Function), var2967_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var2490_bootstrap$/-1486549636=([], java.util.function.IntFunction), var2967_toArray/-73424125=([java.util.stream.Stream, java.util.function.IntFunction], java.lang.Object[]), cast-from-__Array__Int__var197__-to-__Array__Int__var3847__=([java.lang.Object[]], java.net.URL[]), getUrlsFrom/1874242854=([org.springframework.boot.web.servlet.server.StaticResourceJars, java.net.URL[]], java.util.List)}
; {var3840=org.springframework.boot.web.servlet.server.StaticResourceJars, var1266=r0, var197=java.lang.Object, var3429=$r1, var572=java.lang.ClassLoader, var1495=r2, var2301=$z0, var3040=java.lang.management.RuntimeMXBean, var3307=java.lang.management.ManagementFactory, var1903=$r3, var3718=$r5, var1299=java.io.File, var3694=$r4, var3226=$r6, var2967=java.util.stream.Stream, var741=$r8, var160=java.util.function.Function, var1952=org.springframework.boot.web.servlet.server.StaticResourceJars$toUrl__788, var1979=$r7, var2647=$r10, var505=java.util.function.IntFunction, var2490=org.springframework.boot.web.servlet.server.StaticResourceJars$lambda_getUrls_0__794, var1021=$r9, var3942=$r11, var3847=java.net.URL, var2840=$r12, var3731=java.util.List, var2190=$r13}
; {org.springframework.boot.web.servlet.server.StaticResourceJars=var3840, r0=var1266, java.lang.Object=var197, $r1=var3429, java.lang.ClassLoader=var572, r2=var1495, $z0=var2301, java.lang.management.RuntimeMXBean=var3040, java.lang.management.ManagementFactory=var3307, $r3=var1903, $r5=var3718, java.io.File=var1299, $r4=var3694, $r6=var3226, java.util.stream.Stream=var2967, $r8=var741, java.util.function.Function=var160, org.springframework.boot.web.servlet.server.StaticResourceJars$toUrl__788=var1952, $r7=var1979, $r10=var2647, java.util.function.IntFunction=var505, org.springframework.boot.web.servlet.server.StaticResourceJars$lambda_getUrls_0__794=var2490, $r9=var1021, $r11=var3942, java.net.URL=var3847, $r12=var2840, java.util.List=var3731, $r13=var2190}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.springframework.boot.web.servlet.server.StaticResourceJars;	$r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	r2 = virtualinvoke $r1.<java.lang.Class: java.lang.ClassLoader getClassLoader()>();	$z0 = r2 instanceof java.net.URLClassLoader;	if $z0 == 0 goto $r3 = staticinvoke <java.lang.management.ManagementFactory: java.lang.management.RuntimeMXBean getRuntimeMXBean()>();	$r3 = staticinvoke <java.lang.management.ManagementFactory: java.lang.management.RuntimeMXBean getRuntimeMXBean()>();	$r5 = interfaceinvoke $r3.<java.lang.management.RuntimeMXBean: java.lang.String getClassPath()>();	$r4 = <java.io.File: java.lang.String pathSeparator>;	$r6 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>($r4);	$r8 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r6);	$r7 = staticinvoke <org.springframework.boot.web.servlet.server.StaticResourceJars$toUrl__788: java.util.function.Function bootstrap$(org.springframework.boot.web.servlet.server.StaticResourceJars)>(r0);	$r10 = interfaceinvoke $r8.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r7);	$r9 = staticinvoke <org.springframework.boot.web.servlet.server.StaticResourceJars$lambda_getUrls_0__794: java.util.function.IntFunction bootstrap$()>();	$r11 = interfaceinvoke $r10.<java.util.stream.Stream: java.lang.Object[] toArray(java.util.function.IntFunction)>($r9);	$r12 = (java.net.URL[]) $r11;	$r13 = virtualinvoke r0.<org.springframework.boot.web.servlet.server.StaticResourceJars: java.util.List getUrlsFrom(java.net.URL[])>($r12);	return $r13
;block_num 2