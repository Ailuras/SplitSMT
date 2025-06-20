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

(declare-sort var3580 0)
(declare-sort var559 0)
(declare-sort var2286 0)
(declare-sort var660 0)
(declare-sort var2048 0)
(declare-sort var214 0)
(declare-sort var1995 0)
(declare-sort var3076 0)
(declare-sort var1522 0)
(declare-sort var3982 0)
(declare-sort var2455 0)
(declare-sort var511 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var214_currentTimeMillis/630293680 () Int)
(declare-fun getConcurrent/-1808556126 (var3580 var559 var2286) var1995)
(declare-fun get/-785596375 (var1995) Int)
(declare-fun var1522_getUrl/-275947851 (var1522) var3076)
(declare-fun cast-from-var559-to-var1522 (var559) var1522)
(declare-fun getApplication/-536601276 (var3076) String)
(declare-fun var559_getInterface/-1171900879 (var559) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var3982_getMethodName/-516674313 (var2286) String)
(declare-fun getGroup/1342955253 (var3076) String)
(declare-fun getVersion/189836348 (var3076) String)
(declare-fun getSide/-520240817 (var3076) String)
(declare-fun getPort/20614931 (var3076) Int)
(declare-fun var2286_getAttachment/-2134772037 (var2286 String) String)
(declare-fun var2455-init () var2455)
(declare-fun var511_getLocalHost/-1653363627 () String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun arr-String-init () (Array Int String))
(declare-fun String_valueOf/-107395227 (Int) String)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun <init>/-737007403 (var2455 String String Int String (Array Int String)) void)
(declare-const null-var3580 var3580)
(declare-const null-var559 var559)
(declare-const null-var2286 var2286)
(declare-const null-var660 var660)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1858 var3580) ; Statement: r0 := @this: org.apache.dubbo.monitor.support.MonitorFilter 
(assert (not (= var1858 null-var3580)))
(declare-const var1480 var559) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1480 null-var559)))
(declare-const var3544 var2286) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3544 null-var2286)))
(declare-const var3561 var660) ; Statement: r19 := @parameter2: org.apache.dubbo.rpc.Result 
(assert (not (= var3561 null-var660)))
(declare-const var413 String) ; Statement: r17 := @parameter3: java.lang.String 
(assert (not (= var413 null-String)))
(declare-const var2216 Int) ; Statement: l0 := @parameter4: long 
(assert (not (= var2216 null-Int)))
(declare-const var571 Bool) ; Statement: z1 := @parameter5: boolean 
(assert (not (= var571 null-Bool)))
(define-const var1578 Int var214_currentTimeMillis/630293680) ; Statement: $l1 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var888 Int (- var1578 var2216)) ; Statement: l2 = $l1 - l0 
(assert true)
(define-const var2084 var1995 (getConcurrent/-1808556126 var1858 var1480 var3544)) ; Statement: $r3 = specialinvoke r0.<org.apache.dubbo.monitor.support.MonitorFilter: java.util.concurrent.atomic.AtomicInteger getConcurrent(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r2) 
(assert true)
(define-const var2475 Int (get/-785596375 var2084)) ; Statement: i3 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicInteger: int get()>() 
(define-const var287 var3076 (var1522_getUrl/-275947851 (cast-from-var559-to-var1522 var1480))) ; Statement: $r4 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var443 String (getApplication/-536601276 var287)) ; Statement: r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getApplication()>() 
(define-const var1218 ClassObject (var559_getInterface/-1171900879 var1480)) ; Statement: $r6 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>() 
(assert true)
(define-const var2660 String (getName/-1958580599 var1218)) ; Statement: r7 = virtualinvoke $r6.<java.lang.Class: java.lang.String getName()>() 
(define-const var3371 String (var3982_getMethodName/-516674313 var3544)) ; Statement: r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r2) 
(define-const var1172 var3076 (var1522_getUrl/-275947851 (cast-from-var559-to-var1522 var1480))) ; Statement: $r9 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2508 String (getGroup/1342955253 var1172)) ; Statement: r10 = virtualinvoke $r9.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(define-const var501 var3076 (var1522_getUrl/-275947851 (cast-from-var559-to-var1522 var1480))) ; Statement: $r11 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1505 String (getVersion/189836348 var501)) ; Statement: r12 = virtualinvoke $r11.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(define-const var3415 String "consumer") ; Statement: $r15 = "consumer" 
(define-const var2358 var3076 (var1522_getUrl/-275947851 (cast-from-var559-to-var1522 var1480))) ; Statement: $r13 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3690 String (getSide/-520240817 var2358)) ; Statement: $r14 = virtualinvoke $r13.<org.apache.dubbo.common.URL: java.lang.String getSide()>() 
(assert true)
(define-const var2061 Bool (= var3415 var3690)) ; Statement: $z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>($r14) 
 ; Statement: if $z0 == 0 goto $r16 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert (= (ite var2061 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2751 var3076 (var1522_getUrl/-275947851 (cast-from-var559-to-var1522 var1480))) ; Statement: $r16 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var601 Int (getPort/20614931 var2751)) ; Statement: i5 = virtualinvoke $r16.<org.apache.dubbo.common.URL: int getPort()>() 
(define-const var3143 String "consumer") ; Statement: r27 = "consumer" 
(define-const var2708 String var413) ; Statement: r28 = r17 
(assert true) ; Non Conditional
(define-const var3261 String "") ; Statement: r29 = "" 
(define-const var435 String "") ; Statement: r30 = "" 
(define-const var1976 String (var2286_getAttachment/-2134772037 var3544 "input")) ; Statement: $r18 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("input") 
 ; Statement: if $r18 == null goto (branch) 
(assert (= var1976 null-String)) ; Cond: $r18 == null 
 ; Statement: if r19 == null goto $r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert (= var3561 null-var660)) ; Cond: r19 == null 
(define-const var3927 var2455 var2455-init) ; Statement: $r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(define-const var206 String var511_getLocalHost/-1653363627) ; Statement: $r24 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
(define-const var869 Int var601) ; Statement: $i4 = i5 
(define-const var1231 String String-init) ; Statement: $r31 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1231)) ; Statement: specialinvoke $r31.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1231!1 String)
(assert (= var1231!1 ""))
(assert true)
(define-const var955 String (append/672562846 var1231!1 var2660)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var1231!2 String)
(assert (= var1231!2 (str.++ var1231!1 var2660)))
(assert true)
(define-const var535 String (append/672562846 var955 "/")) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var955!1 String)
(assert (= var955!1 (str.++ var955 "/")))
(assert true)
(define-const var812 String (append/672562846 var535 var3371)) ; Statement: $r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var535!1 String)
(assert (= var535!1 (str.++ var535 var3371)))
(assert true)
(define-const var3104 String (toString/-2075883882 var812)) ; Statement: $r23 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3014 (Array Int String) arr-String-init) ; Statement: $r35 = newarray (java.lang.String)[22] 
(declare-const var3014!1 (Array Int String))
(assert (not (= var3014!1 null-__Array__Int__String__)))
(assert (= (select var3014!1 0) "application")) ; Statement: $r35[0] = "application" 
(declare-const var3014!2 (Array Int String))
(assert (not (= var3014!2 null-__Array__Int__String__)))
(assert (= (select var3014!2 1) var443)) ; Statement: $r35[1] = r5 
(declare-const var3014!3 (Array Int String))
(assert (not (= var3014!3 null-__Array__Int__String__)))
(assert (= (select var3014!3 2) "interface")) ; Statement: $r35[2] = "interface" 
(declare-const var3014!4 (Array Int String))
(assert (not (= var3014!4 null-__Array__Int__String__)))
(assert (= (select var3014!4 3) var2660)) ; Statement: $r35[3] = r7 
(declare-const var3014!5 (Array Int String))
(assert (not (= var3014!5 null-__Array__Int__String__)))
(assert (= (select var3014!5 4) "method")) ; Statement: $r35[4] = "method" 
(declare-const var3014!6 (Array Int String))
(assert (not (= var3014!6 null-__Array__Int__String__)))
(assert (= (select var3014!6 5) var3371)) ; Statement: $r35[5] = r8 
(declare-const var3014!7 (Array Int String))
(assert (not (= var3014!7 null-__Array__Int__String__)))
(assert (= (select var3014!7 6) var3143)) ; Statement: $r35[6] = r27 
(declare-const var3014!8 (Array Int String))
(assert (not (= var3014!8 null-__Array__Int__String__)))
(assert (= (select var3014!8 7) var2708)) ; Statement: $r35[7] = r28 
 ; Statement: if z1 == 0 goto $r36 = "success" 
(assert (= (ite var571 1 0) 0)) ; Cond: z1 == 0 
(define-const var3250 String "success") ; Statement: $r36 = "success" 
(assert true) ; Non Conditional
(declare-const var3014!9 (Array Int String))
(assert (not (= var3014!9 null-__Array__Int__String__)))
(assert (= (select var3014!9 8) var3250)) ; Statement: $r35[8] = $r36 
(declare-const var3014!10 (Array Int String))
(assert (not (= var3014!10 null-__Array__Int__String__)))
(assert (= (select var3014!10 9) "1")) ; Statement: $r35[9] = "1" 
(declare-const var3014!11 (Array Int String))
(assert (not (= var3014!11 null-__Array__Int__String__)))
(assert (= (select var3014!11 10) "elapsed")) ; Statement: $r35[10] = "elapsed" 
(define-const var2521 String (String_valueOf/-107395227 var888)) ; Statement: $r21 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l2) 
(declare-const var3014!12 (Array Int String))
(assert (not (= var3014!12 null-__Array__Int__String__)))
(assert (= (select var3014!12 11) var2521)) ; Statement: $r35[11] = $r21 
(declare-const var3014!13 (Array Int String))
(assert (not (= var3014!13 null-__Array__Int__String__)))
(assert (= (select var3014!13 12) "concurrent")) ; Statement: $r35[12] = "concurrent" 
(define-const var2324 String (String_valueOf/1240665136 var2475)) ; Statement: $r22 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i3) 
(declare-const var3014!14 (Array Int String))
(assert (not (= var3014!14 null-__Array__Int__String__)))
(assert (= (select var3014!14 13) var2324)) ; Statement: $r35[13] = $r22 
(declare-const var3014!15 (Array Int String))
(assert (not (= var3014!15 null-__Array__Int__String__)))
(assert (= (select var3014!15 14) "input")) ; Statement: $r35[14] = "input" 
(declare-const var3014!16 (Array Int String))
(assert (not (= var3014!16 null-__Array__Int__String__)))
(assert (= (select var3014!16 15) var3261)) ; Statement: $r35[15] = r29 
(declare-const var3014!17 (Array Int String))
(assert (not (= var3014!17 null-__Array__Int__String__)))
(assert (= (select var3014!17 16) "output")) ; Statement: $r35[16] = "output" 
(declare-const var3014!18 (Array Int String))
(assert (not (= var3014!18 null-__Array__Int__String__)))
(assert (= (select var3014!18 17) var435)) ; Statement: $r35[17] = r30 
(declare-const var3014!19 (Array Int String))
(assert (not (= var3014!19 null-__Array__Int__String__)))
(assert (= (select var3014!19 18) "group")) ; Statement: $r35[18] = "group" 
(declare-const var3014!20 (Array Int String))
(assert (not (= var3014!20 null-__Array__Int__String__)))
(assert (= (select var3014!20 19) var2508)) ; Statement: $r35[19] = r10 
(declare-const var3014!21 (Array Int String))
(assert (not (= var3014!21 null-__Array__Int__String__)))
(assert (= (select var3014!21 20) "version")) ; Statement: $r35[20] = "version" 
(declare-const var3014!22 (Array Int String))
(assert (not (= var3014!22 null-__Array__Int__String__)))
(assert (= (select var3014!22 21) var1505)) ; Statement: $r35[21] = r12 
(assert true)
;(assert (<init>/-737007403 var3927 "count" var206 var869 var3104 var3014!22)) ; Statement: specialinvoke $r20.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.lang.String[])>("count", $r24, $i4, $r23, $r35) 

(declare-const var3927!1 var2455)
(declare-const var3304 String)
(declare-const var206!1 String)
(declare-const var869!1 Int)
(declare-const var3104!1 String)
(declare-const var3014!23 (Array Int String))
 ; Statement: return $r20 
(check-sat)
; {var214_currentTimeMillis/630293680=([], long), getConcurrent/-1808556126=([org.apache.dubbo.monitor.support.MonitorFilter, org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation], java.util.concurrent.atomic.AtomicInteger), get/-785596375=([java.util.concurrent.atomic.AtomicInteger], int), var1522_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var559-to-var1522=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getApplication/-536601276=([org.apache.dubbo.common.URL], java.lang.String), var559_getInterface/-1171900879=([org.apache.dubbo.rpc.Invoker], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), var3982_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), getSide/-520240817=([org.apache.dubbo.common.URL], java.lang.String), getPort/20614931=([org.apache.dubbo.common.URL], int), var2286_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var2455-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), var511_getLocalHost/-1653363627=([], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), arr-String-init=([], java.lang.String[]), String_valueOf/-107395227=([long], java.lang.String), String_valueOf/1240665136=([int], java.lang.String), <init>/-737007403=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, int, java.lang.String, java.lang.String[]], void)}
; {var3580=org.apache.dubbo.monitor.support.MonitorFilter, var1858=r0, var559=org.apache.dubbo.rpc.Invoker, var1480=r1, var2286=org.apache.dubbo.rpc.Invocation, var3544=r2, var660=org.apache.dubbo.rpc.Result, var3561=r19, var413=r17, var2048=null_type, var2216=l0, var571=z1, var214=java.lang.System, var1578=$l1, var888=l2, var1995=java.util.concurrent.atomic.AtomicInteger, var2084=$r3, var2475=i3, var3076=org.apache.dubbo.common.URL, var1522=org.apache.dubbo.common.Node, var287=$r4, var443=r5, var1218=$r6, var2660=r7, var3982=org.apache.dubbo.rpc.support.RpcUtils, var3371=r8, var1172=$r9, var2508=r10, var501=$r11, var1505=r12, var3415=$r15, var2358=$r13, var3690=$r14, var2061=$z0, var2751=$r16, var601=i5, var3143=r27, var2708=r28, var3261=r29, var435=r30, var1976=$r18, var2455=org.apache.dubbo.common.url.component.ServiceConfigURL, var3927=$r20, var511=org.apache.dubbo.common.utils.NetUtils, var206=$r24, var869=$i4, var1231=$r31, var955=$r32, var535=$r33, var812=$r34, var3104=$r23, var3014=$r35, var3250=$r36, var2521=$r21, var2324=$r22, var3304="count"}
; {org.apache.dubbo.monitor.support.MonitorFilter=var3580, r0=var1858, org.apache.dubbo.rpc.Invoker=var559, r1=var1480, org.apache.dubbo.rpc.Invocation=var2286, r2=var3544, org.apache.dubbo.rpc.Result=var660, r19=var3561, r17=var413, null_type=var2048, l0=var2216, z1=var571, java.lang.System=var214, $l1=var1578, l2=var888, java.util.concurrent.atomic.AtomicInteger=var1995, $r3=var2084, i3=var2475, org.apache.dubbo.common.URL=var3076, org.apache.dubbo.common.Node=var1522, $r4=var287, r5=var443, $r6=var1218, r7=var2660, org.apache.dubbo.rpc.support.RpcUtils=var3982, r8=var3371, $r9=var1172, r10=var2508, $r11=var501, r12=var1505, $r15=var3415, $r13=var2358, $r14=var3690, $z0=var2061, $r16=var2751, i5=var601, r27=var3143, r28=var2708, r29=var3261, r30=var435, $r18=var1976, org.apache.dubbo.common.url.component.ServiceConfigURL=var2455, $r20=var3927, org.apache.dubbo.common.utils.NetUtils=var511, $r24=var206, $i4=var869, $r31=var1231, $r32=var955, $r33=var535, $r34=var812, $r23=var3104, $r35=var3014, $r36=var3250, $r21=var2521, $r22=var2324, "count"=var3304}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String valueOf(long)>;	<java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String valueOf(long)>": 1,"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.monitor.support.MonitorFilter;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r2 := @parameter1: org.apache.dubbo.rpc.Invocation;	r19 := @parameter2: org.apache.dubbo.rpc.Result;	r17 := @parameter3: java.lang.String;	l0 := @parameter4: long;	z1 := @parameter5: boolean;	$l1 = staticinvoke <java.lang.System: long currentTimeMillis()>();	l2 = $l1 - l0;	$r3 = specialinvoke r0.<org.apache.dubbo.monitor.support.MonitorFilter: java.util.concurrent.atomic.AtomicInteger getConcurrent(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r2);	i3 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicInteger: int get()>();	$r4 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getApplication()>();	$r6 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>();	r7 = virtualinvoke $r6.<java.lang.Class: java.lang.String getName()>();	r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r2);	$r9 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r10 = virtualinvoke $r9.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r11 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r12 = virtualinvoke $r11.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$r15 = "consumer";	$r13 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r14 = virtualinvoke $r13.<org.apache.dubbo.common.URL: java.lang.String getSide()>();	$z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>($r14);	if $z0 == 0 goto $r16 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r16 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	i5 = virtualinvoke $r16.<org.apache.dubbo.common.URL: int getPort()>();	r27 = "consumer";	r28 = r17;	r29 = "";	r30 = "";	$r18 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("input");	if $r18 == null goto (branch);	if r19 == null goto $r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r24 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	$i4 = i5;	$r31 = new java.lang.StringBuilder;	specialinvoke $r31.<java.lang.StringBuilder: void <init>()>();	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r23 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.String toString()>();	$r35 = newarray (java.lang.String)[22];	$r35[0] = "application";	$r35[1] = r5;	$r35[2] = "interface";	$r35[3] = r7;	$r35[4] = "method";	$r35[5] = r8;	$r35[6] = r27;	$r35[7] = r28;	if z1 == 0 goto $r36 = "success";	$r36 = "success";	$r35[8] = $r36;	$r35[9] = "1";	$r35[10] = "elapsed";	$r21 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l2);	$r35[11] = $r21;	$r35[12] = "concurrent";	$r22 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i3);	$r35[13] = $r22;	$r35[14] = "input";	$r35[15] = r29;	$r35[16] = "output";	$r35[17] = r30;	$r35[18] = "group";	$r35[19] = r10;	$r35[20] = "version";	$r35[21] = r12;	specialinvoke $r20.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.lang.String[])>("count", $r24, $i4, $r23, $r35);	return $r20
;block_num 7