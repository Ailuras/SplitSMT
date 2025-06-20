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

(declare-sort var293 0)
(declare-sort var429 0)
(declare-sort var2369 0)
(declare-sort var3270 0)
(declare-sort var2968 0)
(declare-sort var1823 0)
(declare-sort var2675 0)
(declare-sort var1667 0)
(declare-sort var3069 0)
(declare-sort var2837 0)
(declare-sort var3214 0)
(declare-sort var2215 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1823_currentTimeMillis/630293680 () Int)
(declare-fun getConcurrent/-1808556126 (var293 var429 var2369) var2675)
(declare-fun get/-785596375 (var2675) Int)
(declare-fun var3069_getUrl/-275947851 (var3069) var1667)
(declare-fun cast-from-var429-to-var3069 (var429) var3069)
(declare-fun getApplication/-536601276 (var1667) String)
(declare-fun var429_getInterface/-1171900879 (var429) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var2837_getMethodName/-516674313 (var2369) String)
(declare-fun getGroup/1342955253 (var1667) String)
(declare-fun getVersion/189836348 (var1667) String)
(declare-fun getSide/-520240817 (var1667) String)
(declare-fun getAddress/-2093578336 (var1667) String)
(declare-fun var2369_getAttachment/-2134772037 (var2369 String) String)
(declare-fun var3214-init () var3214)
(declare-fun var2215_getLocalHost/-1653363627 () String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun arr-String-init () (Array Int String))
(declare-fun String_valueOf/-107395227 (Int) String)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun <init>/-737007403 (var3214 String String Int String (Array Int String)) void)
(declare-const null-var293 var293)
(declare-const null-var429 var429)
(declare-const null-var2369 var2369)
(declare-const null-var3270 var3270)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var858 var293) ; Statement: r0 := @this: org.apache.dubbo.monitor.support.MonitorFilter 
(assert (not (= var858 null-var293)))
(declare-const var2721 var429) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var2721 null-var429)))
(declare-const var74 var2369) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var74 null-var2369)))
(declare-const var3602 var3270) ; Statement: r19 := @parameter2: org.apache.dubbo.rpc.Result 
(assert (not (= var3602 null-var3270)))
(declare-const var3457 String) ; Statement: r17 := @parameter3: java.lang.String 
(assert (not (= var3457 null-String)))
(declare-const var1972 Int) ; Statement: l0 := @parameter4: long 
(assert (not (= var1972 null-Int)))
(declare-const var1658 Bool) ; Statement: z1 := @parameter5: boolean 
(assert (not (= var1658 null-Bool)))
(define-const var3391 Int var1823_currentTimeMillis/630293680) ; Statement: $l1 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var250 Int (- var3391 var1972)) ; Statement: l2 = $l1 - l0 
(assert true)
(define-const var3961 var2675 (getConcurrent/-1808556126 var858 var2721 var74)) ; Statement: $r3 = specialinvoke r0.<org.apache.dubbo.monitor.support.MonitorFilter: java.util.concurrent.atomic.AtomicInteger getConcurrent(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r2) 
(assert true)
(define-const var3844 Int (get/-785596375 var3961)) ; Statement: i3 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicInteger: int get()>() 
(define-const var2247 var1667 (var3069_getUrl/-275947851 (cast-from-var429-to-var3069 var2721))) ; Statement: $r4 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2541 String (getApplication/-536601276 var2247)) ; Statement: r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getApplication()>() 
(define-const var1718 ClassObject (var429_getInterface/-1171900879 var2721)) ; Statement: $r6 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>() 
(assert true)
(define-const var1410 String (getName/-1958580599 var1718)) ; Statement: r7 = virtualinvoke $r6.<java.lang.Class: java.lang.String getName()>() 
(define-const var2609 String (var2837_getMethodName/-516674313 var74)) ; Statement: r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r2) 
(define-const var1960 var1667 (var3069_getUrl/-275947851 (cast-from-var429-to-var3069 var2721))) ; Statement: $r9 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2497 String (getGroup/1342955253 var1960)) ; Statement: r10 = virtualinvoke $r9.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(define-const var904 var1667 (var3069_getUrl/-275947851 (cast-from-var429-to-var3069 var2721))) ; Statement: $r11 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1979 String (getVersion/189836348 var904)) ; Statement: r12 = virtualinvoke $r11.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(define-const var2291 String "consumer") ; Statement: $r15 = "consumer" 
(define-const var1645 var1667 (var3069_getUrl/-275947851 (cast-from-var429-to-var3069 var2721))) ; Statement: $r13 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2669 String (getSide/-520240817 var1645)) ; Statement: $r14 = virtualinvoke $r13.<org.apache.dubbo.common.URL: java.lang.String getSide()>() 
(assert true)
(define-const var2285 Bool (= var2291 var2669)) ; Statement: $z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>($r14) 
 ; Statement: if $z0 == 0 goto $r16 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert (not (= (ite var2285 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2984 Int 0) ; Statement: i5 = 0 
(define-const var196 String "provider") ; Statement: r27 = "provider" 
(define-const var3185 var1667 (var3069_getUrl/-275947851 (cast-from-var429-to-var3069 var2721))) ; Statement: $r26 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3022 String (getAddress/-2093578336 var3185)) ; Statement: r28 = virtualinvoke $r26.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
 ; Statement: goto [?= r29 = ""] 
(assert true) ; Non Conditional
(define-const var581 String "") ; Statement: r29 = "" 
(define-const var754 String "") ; Statement: r30 = "" 
(define-const var1481 String (var2369_getAttachment/-2134772037 var74 "input")) ; Statement: $r18 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("input") 
 ; Statement: if $r18 == null goto (branch) 
(assert (= var1481 null-String)) ; Cond: $r18 == null 
 ; Statement: if r19 == null goto $r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert (= var3602 null-var3270)) ; Cond: r19 == null 
(define-const var3511 var3214 var3214-init) ; Statement: $r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(define-const var2417 String var2215_getLocalHost/-1653363627) ; Statement: $r24 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
(define-const var1042 Int var2984) ; Statement: $i4 = i5 
(define-const var55 String String-init) ; Statement: $r31 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var55)) ; Statement: specialinvoke $r31.<java.lang.StringBuilder: void <init>()>() 
(declare-const var55!1 String)
(assert (= var55!1 ""))
(assert true)
(define-const var413 String (append/672562846 var55!1 var1410)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var55!2 String)
(assert (= var55!2 (str.++ var55!1 var1410)))
(assert true)
(define-const var1454 String (append/672562846 var413 "/")) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var413!1 String)
(assert (= var413!1 (str.++ var413 "/")))
(assert true)
(define-const var2140 String (append/672562846 var1454 var2609)) ; Statement: $r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var1454!1 String)
(assert (= var1454!1 (str.++ var1454 var2609)))
(assert true)
(define-const var3259 String (toString/-2075883882 var2140)) ; Statement: $r23 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var37 (Array Int String) arr-String-init) ; Statement: $r35 = newarray (java.lang.String)[22] 
(declare-const var37!1 (Array Int String))
(assert (not (= var37!1 null-__Array__Int__String__)))
(assert (= (select var37!1 0) "application")) ; Statement: $r35[0] = "application" 
(declare-const var37!2 (Array Int String))
(assert (not (= var37!2 null-__Array__Int__String__)))
(assert (= (select var37!2 1) var2541)) ; Statement: $r35[1] = r5 
(declare-const var37!3 (Array Int String))
(assert (not (= var37!3 null-__Array__Int__String__)))
(assert (= (select var37!3 2) "interface")) ; Statement: $r35[2] = "interface" 
(declare-const var37!4 (Array Int String))
(assert (not (= var37!4 null-__Array__Int__String__)))
(assert (= (select var37!4 3) var1410)) ; Statement: $r35[3] = r7 
(declare-const var37!5 (Array Int String))
(assert (not (= var37!5 null-__Array__Int__String__)))
(assert (= (select var37!5 4) "method")) ; Statement: $r35[4] = "method" 
(declare-const var37!6 (Array Int String))
(assert (not (= var37!6 null-__Array__Int__String__)))
(assert (= (select var37!6 5) var2609)) ; Statement: $r35[5] = r8 
(declare-const var37!7 (Array Int String))
(assert (not (= var37!7 null-__Array__Int__String__)))
(assert (= (select var37!7 6) var196)) ; Statement: $r35[6] = r27 
(declare-const var37!8 (Array Int String))
(assert (not (= var37!8 null-__Array__Int__String__)))
(assert (= (select var37!8 7) var3022)) ; Statement: $r35[7] = r28 
 ; Statement: if z1 == 0 goto $r36 = "success" 
(assert (= (ite var1658 1 0) 0)) ; Cond: z1 == 0 
(define-const var2605 String "success") ; Statement: $r36 = "success" 
(assert true) ; Non Conditional
(declare-const var37!9 (Array Int String))
(assert (not (= var37!9 null-__Array__Int__String__)))
(assert (= (select var37!9 8) var2605)) ; Statement: $r35[8] = $r36 
(declare-const var37!10 (Array Int String))
(assert (not (= var37!10 null-__Array__Int__String__)))
(assert (= (select var37!10 9) "1")) ; Statement: $r35[9] = "1" 
(declare-const var37!11 (Array Int String))
(assert (not (= var37!11 null-__Array__Int__String__)))
(assert (= (select var37!11 10) "elapsed")) ; Statement: $r35[10] = "elapsed" 
(define-const var3688 String (String_valueOf/-107395227 var250)) ; Statement: $r21 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l2) 
(declare-const var37!12 (Array Int String))
(assert (not (= var37!12 null-__Array__Int__String__)))
(assert (= (select var37!12 11) var3688)) ; Statement: $r35[11] = $r21 
(declare-const var37!13 (Array Int String))
(assert (not (= var37!13 null-__Array__Int__String__)))
(assert (= (select var37!13 12) "concurrent")) ; Statement: $r35[12] = "concurrent" 
(define-const var2447 String (String_valueOf/1240665136 var3844)) ; Statement: $r22 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i3) 
(declare-const var37!14 (Array Int String))
(assert (not (= var37!14 null-__Array__Int__String__)))
(assert (= (select var37!14 13) var2447)) ; Statement: $r35[13] = $r22 
(declare-const var37!15 (Array Int String))
(assert (not (= var37!15 null-__Array__Int__String__)))
(assert (= (select var37!15 14) "input")) ; Statement: $r35[14] = "input" 
(declare-const var37!16 (Array Int String))
(assert (not (= var37!16 null-__Array__Int__String__)))
(assert (= (select var37!16 15) var581)) ; Statement: $r35[15] = r29 
(declare-const var37!17 (Array Int String))
(assert (not (= var37!17 null-__Array__Int__String__)))
(assert (= (select var37!17 16) "output")) ; Statement: $r35[16] = "output" 
(declare-const var37!18 (Array Int String))
(assert (not (= var37!18 null-__Array__Int__String__)))
(assert (= (select var37!18 17) var754)) ; Statement: $r35[17] = r30 
(declare-const var37!19 (Array Int String))
(assert (not (= var37!19 null-__Array__Int__String__)))
(assert (= (select var37!19 18) "group")) ; Statement: $r35[18] = "group" 
(declare-const var37!20 (Array Int String))
(assert (not (= var37!20 null-__Array__Int__String__)))
(assert (= (select var37!20 19) var2497)) ; Statement: $r35[19] = r10 
(declare-const var37!21 (Array Int String))
(assert (not (= var37!21 null-__Array__Int__String__)))
(assert (= (select var37!21 20) "version")) ; Statement: $r35[20] = "version" 
(declare-const var37!22 (Array Int String))
(assert (not (= var37!22 null-__Array__Int__String__)))
(assert (= (select var37!22 21) var1979)) ; Statement: $r35[21] = r12 
(assert true)
;(assert (<init>/-737007403 var3511 "count" var2417 var1042 var3259 var37!22)) ; Statement: specialinvoke $r20.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.lang.String[])>("count", $r24, $i4, $r23, $r35) 

(declare-const var3511!1 var3214)
(declare-const var1437 String)
(declare-const var2417!1 String)
(declare-const var1042!1 Int)
(declare-const var3259!1 String)
(declare-const var37!23 (Array Int String))
 ; Statement: return $r20 
(check-sat)
; {var1823_currentTimeMillis/630293680=([], long), getConcurrent/-1808556126=([org.apache.dubbo.monitor.support.MonitorFilter, org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation], java.util.concurrent.atomic.AtomicInteger), get/-785596375=([java.util.concurrent.atomic.AtomicInteger], int), var3069_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var429-to-var3069=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getApplication/-536601276=([org.apache.dubbo.common.URL], java.lang.String), var429_getInterface/-1171900879=([org.apache.dubbo.rpc.Invoker], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), var2837_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), getSide/-520240817=([org.apache.dubbo.common.URL], java.lang.String), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), var2369_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var3214-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), var2215_getLocalHost/-1653363627=([], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), arr-String-init=([], java.lang.String[]), String_valueOf/-107395227=([long], java.lang.String), String_valueOf/1240665136=([int], java.lang.String), <init>/-737007403=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, int, java.lang.String, java.lang.String[]], void)}
; {var293=org.apache.dubbo.monitor.support.MonitorFilter, var858=r0, var429=org.apache.dubbo.rpc.Invoker, var2721=r1, var2369=org.apache.dubbo.rpc.Invocation, var74=r2, var3270=org.apache.dubbo.rpc.Result, var3602=r19, var3457=r17, var2968=null_type, var1972=l0, var1658=z1, var1823=java.lang.System, var3391=$l1, var250=l2, var2675=java.util.concurrent.atomic.AtomicInteger, var3961=$r3, var3844=i3, var1667=org.apache.dubbo.common.URL, var3069=org.apache.dubbo.common.Node, var2247=$r4, var2541=r5, var1718=$r6, var1410=r7, var2837=org.apache.dubbo.rpc.support.RpcUtils, var2609=r8, var1960=$r9, var2497=r10, var904=$r11, var1979=r12, var2291=$r15, var1645=$r13, var2669=$r14, var2285=$z0, var2984=i5, var196=r27, var3185=$r26, var3022=r28, var581=r29, var754=r30, var1481=$r18, var3214=org.apache.dubbo.common.url.component.ServiceConfigURL, var3511=$r20, var2215=org.apache.dubbo.common.utils.NetUtils, var2417=$r24, var1042=$i4, var55=$r31, var413=$r32, var1454=$r33, var2140=$r34, var3259=$r23, var37=$r35, var2605=$r36, var3688=$r21, var2447=$r22, var1437="count"}
; {org.apache.dubbo.monitor.support.MonitorFilter=var293, r0=var858, org.apache.dubbo.rpc.Invoker=var429, r1=var2721, org.apache.dubbo.rpc.Invocation=var2369, r2=var74, org.apache.dubbo.rpc.Result=var3270, r19=var3602, r17=var3457, null_type=var2968, l0=var1972, z1=var1658, java.lang.System=var1823, $l1=var3391, l2=var250, java.util.concurrent.atomic.AtomicInteger=var2675, $r3=var3961, i3=var3844, org.apache.dubbo.common.URL=var1667, org.apache.dubbo.common.Node=var3069, $r4=var2247, r5=var2541, $r6=var1718, r7=var1410, org.apache.dubbo.rpc.support.RpcUtils=var2837, r8=var2609, $r9=var1960, r10=var2497, $r11=var904, r12=var1979, $r15=var2291, $r13=var1645, $r14=var2669, $z0=var2285, i5=var2984, r27=var196, $r26=var3185, r28=var3022, r29=var581, r30=var754, $r18=var1481, org.apache.dubbo.common.url.component.ServiceConfigURL=var3214, $r20=var3511, org.apache.dubbo.common.utils.NetUtils=var2215, $r24=var2417, $i4=var1042, $r31=var55, $r32=var413, $r33=var1454, $r34=var2140, $r23=var3259, $r35=var37, $r36=var2605, $r21=var3688, $r22=var2447, "count"=var1437}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String valueOf(long)>;	<java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String valueOf(long)>": 1,"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.monitor.support.MonitorFilter;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r2 := @parameter1: org.apache.dubbo.rpc.Invocation;	r19 := @parameter2: org.apache.dubbo.rpc.Result;	r17 := @parameter3: java.lang.String;	l0 := @parameter4: long;	z1 := @parameter5: boolean;	$l1 = staticinvoke <java.lang.System: long currentTimeMillis()>();	l2 = $l1 - l0;	$r3 = specialinvoke r0.<org.apache.dubbo.monitor.support.MonitorFilter: java.util.concurrent.atomic.AtomicInteger getConcurrent(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r2);	i3 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicInteger: int get()>();	$r4 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getApplication()>();	$r6 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>();	r7 = virtualinvoke $r6.<java.lang.Class: java.lang.String getName()>();	r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r2);	$r9 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r10 = virtualinvoke $r9.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r11 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r12 = virtualinvoke $r11.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$r15 = "consumer";	$r13 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r14 = virtualinvoke $r13.<org.apache.dubbo.common.URL: java.lang.String getSide()>();	$z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>($r14);	if $z0 == 0 goto $r16 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	i5 = 0;	r27 = "provider";	$r26 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r28 = virtualinvoke $r26.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	goto [?= r29 = ""];	r29 = "";	r30 = "";	$r18 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("input");	if $r18 == null goto (branch);	if r19 == null goto $r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r24 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	$i4 = i5;	$r31 = new java.lang.StringBuilder;	specialinvoke $r31.<java.lang.StringBuilder: void <init>()>();	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r23 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.String toString()>();	$r35 = newarray (java.lang.String)[22];	$r35[0] = "application";	$r35[1] = r5;	$r35[2] = "interface";	$r35[3] = r7;	$r35[4] = "method";	$r35[5] = r8;	$r35[6] = r27;	$r35[7] = r28;	if z1 == 0 goto $r36 = "success";	$r36 = "success";	$r35[8] = $r36;	$r35[9] = "1";	$r35[10] = "elapsed";	$r21 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l2);	$r35[11] = $r21;	$r35[12] = "concurrent";	$r22 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i3);	$r35[13] = $r22;	$r35[14] = "input";	$r35[15] = r29;	$r35[16] = "output";	$r35[17] = r30;	$r35[18] = "group";	$r35[19] = r10;	$r35[20] = "version";	$r35[21] = r12;	specialinvoke $r20.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.lang.String[])>("count", $r24, $i4, $r23, $r35);	return $r20
;block_num 7