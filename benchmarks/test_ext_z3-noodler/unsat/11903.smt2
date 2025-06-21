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

(declare-sort var895 0)
(declare-sort var1185 0)
(declare-sort var971 0)
(declare-sort var848 0)
(declare-sort var2154 0)
(declare-sort var196 0)
(declare-sort var1200 0)
(declare-sort var3443 0)
(declare-sort var3628 0)
(declare-sort var1979 0)
(declare-sort var1663 0)
(declare-sort var3573 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var196_currentTimeMillis/630293680 () Int)
(declare-fun getConcurrent/-1808556126 (var895 var1185 var971) var1200)
(declare-fun get/-785596375 (var1200) Int)
(declare-fun var3628_getUrl/-275947851 (var3628) var3443)
(declare-fun cast-from-var1185-to-var3628 (var1185) var3628)
(declare-fun getApplication/-536601276 (var3443) String)
(declare-fun var1185_getInterface/-1171900879 (var1185) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var1979_getMethodName/-516674313 (var971) String)
(declare-fun getGroup/1342955253 (var3443) String)
(declare-fun getVersion/189836348 (var3443) String)
(declare-fun getSide/-520240817 (var3443) String)
(declare-fun getPort/20614931 (var3443) Int)
(declare-fun var971_getAttachment/-2134772037 (var971 String) String)
(declare-fun var1663-init () var1663)
(declare-fun var3573_getLocalHost/-1653363627 () String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun arr-String-init () (Array Int String))
(declare-fun String_valueOf/-107395227 (Int) String)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun <init>/-737007403 (var1663 String String Int String (Array Int String)) void)
(declare-const null-var895 var895)
(declare-const null-var1185 var1185)
(declare-const null-var971 var971)
(declare-const null-var848 var848)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1960 var895) ; Statement: r0 := @this: org.apache.dubbo.monitor.support.MonitorFilter 
(assert (not (= var1960 null-var895)))
(declare-const var2060 var1185) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var2060 null-var1185)))
(declare-const var3663 var971) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3663 null-var971)))
(declare-const var2457 var848) ; Statement: r19 := @parameter2: org.apache.dubbo.rpc.Result 
(assert (not (= var2457 null-var848)))
(declare-const var2831 String) ; Statement: r17 := @parameter3: java.lang.String 
(assert (not (= var2831 null-String)))
(declare-const var1413 Int) ; Statement: l0 := @parameter4: long 
(assert (not (= var1413 null-Int)))
(declare-const var3160 Bool) ; Statement: z1 := @parameter5: boolean 
(assert (not (= var3160 null-Bool)))
(define-const var572 Int var196_currentTimeMillis/630293680) ; Statement: $l1 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var630 Int (- var572 var1413)) ; Statement: l2 = $l1 - l0 
(assert true)
(define-const var2621 var1200 (getConcurrent/-1808556126 var1960 var2060 var3663)) ; Statement: $r3 = specialinvoke r0.<org.apache.dubbo.monitor.support.MonitorFilter: java.util.concurrent.atomic.AtomicInteger getConcurrent(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r2) 
(assert true)
(define-const var926 Int (get/-785596375 var2621)) ; Statement: i3 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicInteger: int get()>() 
(define-const var1253 var3443 (var3628_getUrl/-275947851 (cast-from-var1185-to-var3628 var2060))) ; Statement: $r4 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3354 String (getApplication/-536601276 var1253)) ; Statement: r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getApplication()>() 
(define-const var1342 ClassObject (var1185_getInterface/-1171900879 var2060)) ; Statement: $r6 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>() 
(assert true)
(define-const var2138 String (getName/-1958580599 var1342)) ; Statement: r7 = virtualinvoke $r6.<java.lang.Class: java.lang.String getName()>() 
(define-const var1056 String (var1979_getMethodName/-516674313 var3663)) ; Statement: r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r2) 
(define-const var2261 var3443 (var3628_getUrl/-275947851 (cast-from-var1185-to-var3628 var2060))) ; Statement: $r9 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1724 String (getGroup/1342955253 var2261)) ; Statement: r10 = virtualinvoke $r9.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(define-const var723 var3443 (var3628_getUrl/-275947851 (cast-from-var1185-to-var3628 var2060))) ; Statement: $r11 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1808 String (getVersion/189836348 var723)) ; Statement: r12 = virtualinvoke $r11.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(define-const var1710 String "consumer") ; Statement: $r15 = "consumer" 
(define-const var3275 var3443 (var3628_getUrl/-275947851 (cast-from-var1185-to-var3628 var2060))) ; Statement: $r13 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1803 String (getSide/-520240817 var3275)) ; Statement: $r14 = virtualinvoke $r13.<org.apache.dubbo.common.URL: java.lang.String getSide()>() 
(assert true)
(define-const var489 Bool (= var1710 var1803)) ; Statement: $z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>($r14) 
 ; Statement: if $z0 == 0 goto $r16 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert (= (ite var489 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1019 var3443 (var3628_getUrl/-275947851 (cast-from-var1185-to-var3628 var2060))) ; Statement: $r16 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1133 Int (getPort/20614931 var1019)) ; Statement: i5 = virtualinvoke $r16.<org.apache.dubbo.common.URL: int getPort()>() 
(define-const var1474 String "consumer") ; Statement: r27 = "consumer" 
(define-const var745 String var2831) ; Statement: r28 = r17 
(assert true) ; Non Conditional
(define-const var2890 String "") ; Statement: r29 = "" 
(define-const var3827 String "") ; Statement: r30 = "" 
(define-const var3188 String (var971_getAttachment/-2134772037 var3663 "input")) ; Statement: $r18 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("input") 
 ; Statement: if $r18 == null goto (branch) 
(assert (= var3188 null-String)) ; Cond: $r18 == null 
 ; Statement: if r19 == null goto $r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert (= var2457 null-var848)) ; Cond: r19 == null 
(define-const var3893 var1663 var1663-init) ; Statement: $r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(define-const var2611 String var3573_getLocalHost/-1653363627) ; Statement: $r24 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
(define-const var3259 Int var1133) ; Statement: $i4 = i5 
(define-const var2108 String String-init) ; Statement: $r31 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2108)) ; Statement: specialinvoke $r31.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2108!1 String)
(assert (= var2108!1 ""))
(assert true)
(define-const var3581 String (append/672562846 var2108!1 var2138)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var2108!2 String)
(assert (= var2108!2 (str.++ var2108!1 var2138)))
(assert true)
(define-const var3027 String (append/672562846 var3581 "/")) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var3581!1 String)
(assert (= var3581!1 (str.++ var3581 "/")))
(assert true)
(define-const var2616 String (append/672562846 var3027 var1056)) ; Statement: $r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var3027!1 String)
(assert (= var3027!1 (str.++ var3027 var1056)))
(assert true)
(define-const var1798 String (toString/-2075883882 var2616)) ; Statement: $r23 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1830 (Array Int String) arr-String-init) ; Statement: $r35 = newarray (java.lang.String)[22] 
(declare-const var1830!1 (Array Int String))
(assert (not (= var1830!1 null-__Array__Int__String__)))
(assert (= (select var1830!1 0) "application")) ; Statement: $r35[0] = "application" 
(declare-const var1830!2 (Array Int String))
(assert (not (= var1830!2 null-__Array__Int__String__)))
(assert (= (select var1830!2 1) var3354)) ; Statement: $r35[1] = r5 
(declare-const var1830!3 (Array Int String))
(assert (not (= var1830!3 null-__Array__Int__String__)))
(assert (= (select var1830!3 2) "interface")) ; Statement: $r35[2] = "interface" 
(declare-const var1830!4 (Array Int String))
(assert (not (= var1830!4 null-__Array__Int__String__)))
(assert (= (select var1830!4 3) var2138)) ; Statement: $r35[3] = r7 
(declare-const var1830!5 (Array Int String))
(assert (not (= var1830!5 null-__Array__Int__String__)))
(assert (= (select var1830!5 4) "method")) ; Statement: $r35[4] = "method" 
(declare-const var1830!6 (Array Int String))
(assert (not (= var1830!6 null-__Array__Int__String__)))
(assert (= (select var1830!6 5) var1056)) ; Statement: $r35[5] = r8 
(declare-const var1830!7 (Array Int String))
(assert (not (= var1830!7 null-__Array__Int__String__)))
(assert (= (select var1830!7 6) var1474)) ; Statement: $r35[6] = r27 
(declare-const var1830!8 (Array Int String))
(assert (not (= var1830!8 null-__Array__Int__String__)))
(assert (= (select var1830!8 7) var745)) ; Statement: $r35[7] = r28 
 ; Statement: if z1 == 0 goto $r36 = "success" 
(assert (not (= (ite var3160 1 0) 0))) ; Negate: Cond: z1 == 0  
(define-const var3575 String "failure") ; Statement: $r36 = "failure" 
 ; Statement: goto [?= $r35[8] = $r36] 
(assert true) ; Non Conditional
(declare-const var1830!9 (Array Int String))
(assert (not (= var1830!9 null-__Array__Int__String__)))
(assert (= (select var1830!9 8) var3575)) ; Statement: $r35[8] = $r36 
(declare-const var1830!10 (Array Int String))
(assert (not (= var1830!10 null-__Array__Int__String__)))
(assert (= (select var1830!10 9) "1")) ; Statement: $r35[9] = "1" 
(declare-const var1830!11 (Array Int String))
(assert (not (= var1830!11 null-__Array__Int__String__)))
(assert (= (select var1830!11 10) "elapsed")) ; Statement: $r35[10] = "elapsed" 
(define-const var2658 String (String_valueOf/-107395227 var630)) ; Statement: $r21 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l2) 
(declare-const var1830!12 (Array Int String))
(assert (not (= var1830!12 null-__Array__Int__String__)))
(assert (= (select var1830!12 11) var2658)) ; Statement: $r35[11] = $r21 
(declare-const var1830!13 (Array Int String))
(assert (not (= var1830!13 null-__Array__Int__String__)))
(assert (= (select var1830!13 12) "concurrent")) ; Statement: $r35[12] = "concurrent" 
(define-const var1841 String (String_valueOf/1240665136 var926)) ; Statement: $r22 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i3) 
(declare-const var1830!14 (Array Int String))
(assert (not (= var1830!14 null-__Array__Int__String__)))
(assert (= (select var1830!14 13) var1841)) ; Statement: $r35[13] = $r22 
(declare-const var1830!15 (Array Int String))
(assert (not (= var1830!15 null-__Array__Int__String__)))
(assert (= (select var1830!15 14) "input")) ; Statement: $r35[14] = "input" 
(declare-const var1830!16 (Array Int String))
(assert (not (= var1830!16 null-__Array__Int__String__)))
(assert (= (select var1830!16 15) var2890)) ; Statement: $r35[15] = r29 
(declare-const var1830!17 (Array Int String))
(assert (not (= var1830!17 null-__Array__Int__String__)))
(assert (= (select var1830!17 16) "output")) ; Statement: $r35[16] = "output" 
(declare-const var1830!18 (Array Int String))
(assert (not (= var1830!18 null-__Array__Int__String__)))
(assert (= (select var1830!18 17) var3827)) ; Statement: $r35[17] = r30 
(declare-const var1830!19 (Array Int String))
(assert (not (= var1830!19 null-__Array__Int__String__)))
(assert (= (select var1830!19 18) "group")) ; Statement: $r35[18] = "group" 
(declare-const var1830!20 (Array Int String))
(assert (not (= var1830!20 null-__Array__Int__String__)))
(assert (= (select var1830!20 19) var1724)) ; Statement: $r35[19] = r10 
(declare-const var1830!21 (Array Int String))
(assert (not (= var1830!21 null-__Array__Int__String__)))
(assert (= (select var1830!21 20) "version")) ; Statement: $r35[20] = "version" 
(declare-const var1830!22 (Array Int String))
(assert (not (= var1830!22 null-__Array__Int__String__)))
(assert (= (select var1830!22 21) var1808)) ; Statement: $r35[21] = r12 
(assert true)
;(assert (<init>/-737007403 var3893 "count" var2611 var3259 var1798 var1830!22)) ; Statement: specialinvoke $r20.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.lang.String[])>("count", $r24, $i4, $r23, $r35) 

(declare-const var3893!1 var1663)
(declare-const var1670 String)
(declare-const var2611!1 String)
(declare-const var3259!1 Int)
(declare-const var1798!1 String)
(declare-const var1830!23 (Array Int String))
 ; Statement: return $r20 
(check-sat)
; {var196_currentTimeMillis/630293680=([], long), getConcurrent/-1808556126=([org.apache.dubbo.monitor.support.MonitorFilter, org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation], java.util.concurrent.atomic.AtomicInteger), get/-785596375=([java.util.concurrent.atomic.AtomicInteger], int), var3628_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1185-to-var3628=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getApplication/-536601276=([org.apache.dubbo.common.URL], java.lang.String), var1185_getInterface/-1171900879=([org.apache.dubbo.rpc.Invoker], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), var1979_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), getSide/-520240817=([org.apache.dubbo.common.URL], java.lang.String), getPort/20614931=([org.apache.dubbo.common.URL], int), var971_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var1663-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), var3573_getLocalHost/-1653363627=([], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), arr-String-init=([], java.lang.String[]), String_valueOf/-107395227=([long], java.lang.String), String_valueOf/1240665136=([int], java.lang.String), <init>/-737007403=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, int, java.lang.String, java.lang.String[]], void)}
; {var895=org.apache.dubbo.monitor.support.MonitorFilter, var1960=r0, var1185=org.apache.dubbo.rpc.Invoker, var2060=r1, var971=org.apache.dubbo.rpc.Invocation, var3663=r2, var848=org.apache.dubbo.rpc.Result, var2457=r19, var2831=r17, var2154=null_type, var1413=l0, var3160=z1, var196=java.lang.System, var572=$l1, var630=l2, var1200=java.util.concurrent.atomic.AtomicInteger, var2621=$r3, var926=i3, var3443=org.apache.dubbo.common.URL, var3628=org.apache.dubbo.common.Node, var1253=$r4, var3354=r5, var1342=$r6, var2138=r7, var1979=org.apache.dubbo.rpc.support.RpcUtils, var1056=r8, var2261=$r9, var1724=r10, var723=$r11, var1808=r12, var1710=$r15, var3275=$r13, var1803=$r14, var489=$z0, var1019=$r16, var1133=i5, var1474=r27, var745=r28, var2890=r29, var3827=r30, var3188=$r18, var1663=org.apache.dubbo.common.url.component.ServiceConfigURL, var3893=$r20, var3573=org.apache.dubbo.common.utils.NetUtils, var2611=$r24, var3259=$i4, var2108=$r31, var3581=$r32, var3027=$r33, var2616=$r34, var1798=$r23, var1830=$r35, var3575=$r36, var2658=$r21, var1841=$r22, var1670="count"}
; {org.apache.dubbo.monitor.support.MonitorFilter=var895, r0=var1960, org.apache.dubbo.rpc.Invoker=var1185, r1=var2060, org.apache.dubbo.rpc.Invocation=var971, r2=var3663, org.apache.dubbo.rpc.Result=var848, r19=var2457, r17=var2831, null_type=var2154, l0=var1413, z1=var3160, java.lang.System=var196, $l1=var572, l2=var630, java.util.concurrent.atomic.AtomicInteger=var1200, $r3=var2621, i3=var926, org.apache.dubbo.common.URL=var3443, org.apache.dubbo.common.Node=var3628, $r4=var1253, r5=var3354, $r6=var1342, r7=var2138, org.apache.dubbo.rpc.support.RpcUtils=var1979, r8=var1056, $r9=var2261, r10=var1724, $r11=var723, r12=var1808, $r15=var1710, $r13=var3275, $r14=var1803, $z0=var489, $r16=var1019, i5=var1133, r27=var1474, r28=var745, r29=var2890, r30=var3827, $r18=var3188, org.apache.dubbo.common.url.component.ServiceConfigURL=var1663, $r20=var3893, org.apache.dubbo.common.utils.NetUtils=var3573, $r24=var2611, $i4=var3259, $r31=var2108, $r32=var3581, $r33=var3027, $r34=var2616, $r23=var1798, $r35=var1830, $r36=var3575, $r21=var2658, $r22=var1841, "count"=var1670}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String valueOf(long)>;	<java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String valueOf(long)>": 1,"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.monitor.support.MonitorFilter;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r2 := @parameter1: org.apache.dubbo.rpc.Invocation;	r19 := @parameter2: org.apache.dubbo.rpc.Result;	r17 := @parameter3: java.lang.String;	l0 := @parameter4: long;	z1 := @parameter5: boolean;	$l1 = staticinvoke <java.lang.System: long currentTimeMillis()>();	l2 = $l1 - l0;	$r3 = specialinvoke r0.<org.apache.dubbo.monitor.support.MonitorFilter: java.util.concurrent.atomic.AtomicInteger getConcurrent(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r2);	i3 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicInteger: int get()>();	$r4 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getApplication()>();	$r6 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>();	r7 = virtualinvoke $r6.<java.lang.Class: java.lang.String getName()>();	r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r2);	$r9 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r10 = virtualinvoke $r9.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r11 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r12 = virtualinvoke $r11.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$r15 = "consumer";	$r13 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r14 = virtualinvoke $r13.<org.apache.dubbo.common.URL: java.lang.String getSide()>();	$z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>($r14);	if $z0 == 0 goto $r16 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r16 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	i5 = virtualinvoke $r16.<org.apache.dubbo.common.URL: int getPort()>();	r27 = "consumer";	r28 = r17;	r29 = "";	r30 = "";	$r18 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("input");	if $r18 == null goto (branch);	if r19 == null goto $r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r24 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	$i4 = i5;	$r31 = new java.lang.StringBuilder;	specialinvoke $r31.<java.lang.StringBuilder: void <init>()>();	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r23 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.String toString()>();	$r35 = newarray (java.lang.String)[22];	$r35[0] = "application";	$r35[1] = r5;	$r35[2] = "interface";	$r35[3] = r7;	$r35[4] = "method";	$r35[5] = r8;	$r35[6] = r27;	$r35[7] = r28;	if z1 == 0 goto $r36 = "success";	$r36 = "failure";	goto [?= $r35[8] = $r36];	$r35[8] = $r36;	$r35[9] = "1";	$r35[10] = "elapsed";	$r21 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l2);	$r35[11] = $r21;	$r35[12] = "concurrent";	$r22 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i3);	$r35[13] = $r22;	$r35[14] = "input";	$r35[15] = r29;	$r35[16] = "output";	$r35[17] = r30;	$r35[18] = "group";	$r35[19] = r10;	$r35[20] = "version";	$r35[21] = r12;	specialinvoke $r20.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.lang.String[])>("count", $r24, $i4, $r23, $r35);	return $r20
;block_num 7