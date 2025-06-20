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

(declare-sort var330 0)
(declare-sort var3920 0)
(declare-sort var1562 0)
(declare-sort var3220 0)
(declare-sort var2393 0)
(declare-sort var3190 0)
(declare-sort var1692 0)
(declare-sort var1106 0)
(declare-sort var3166 0)
(declare-sort var3063 0)
(declare-sort var3835 0)
(declare-sort var31 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3190_currentTimeMillis/630293680 () Int)
(declare-fun getConcurrent/-1808556126 (var330 var3920 var1562) var1692)
(declare-fun get/-785596375 (var1692) Int)
(declare-fun var3166_getUrl/-275947851 (var3166) var1106)
(declare-fun cast-from-var3920-to-var3166 (var3920) var3166)
(declare-fun getApplication/-536601276 (var1106) String)
(declare-fun var3920_getInterface/-1171900879 (var3920) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var3063_getMethodName/-516674313 (var1562) String)
(declare-fun getGroup/1342955253 (var1106) String)
(declare-fun getVersion/189836348 (var1106) String)
(declare-fun getSide/-520240817 (var1106) String)
(declare-fun getAddress/-2093578336 (var1106) String)
(declare-fun var1562_getAttachment/-2134772037 (var1562 String) String)
(declare-fun var3835-init () var3835)
(declare-fun var31_getLocalHost/-1653363627 () String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun arr-String-init () (Array Int String))
(declare-fun String_valueOf/-107395227 (Int) String)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun <init>/-737007403 (var3835 String String Int String (Array Int String)) void)
(declare-const null-var330 var330)
(declare-const null-var3920 var3920)
(declare-const null-var1562 var1562)
(declare-const null-var3220 var3220)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var2315 var330) ; Statement: r0 := @this: org.apache.dubbo.monitor.support.MonitorFilter 
(assert (not (= var2315 null-var330)))
(declare-const var2371 var3920) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var2371 null-var3920)))
(declare-const var3679 var1562) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3679 null-var1562)))
(declare-const var2993 var3220) ; Statement: r19 := @parameter2: org.apache.dubbo.rpc.Result 
(assert (not (= var2993 null-var3220)))
(declare-const var3873 String) ; Statement: r17 := @parameter3: java.lang.String 
(assert (not (= var3873 null-String)))
(declare-const var392 Int) ; Statement: l0 := @parameter4: long 
(assert (not (= var392 null-Int)))
(declare-const var2318 Bool) ; Statement: z1 := @parameter5: boolean 
(assert (not (= var2318 null-Bool)))
(define-const var2809 Int var3190_currentTimeMillis/630293680) ; Statement: $l1 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var215 Int (- var2809 var392)) ; Statement: l2 = $l1 - l0 
(assert true)
(define-const var940 var1692 (getConcurrent/-1808556126 var2315 var2371 var3679)) ; Statement: $r3 = specialinvoke r0.<org.apache.dubbo.monitor.support.MonitorFilter: java.util.concurrent.atomic.AtomicInteger getConcurrent(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r2) 
(assert true)
(define-const var3052 Int (get/-785596375 var940)) ; Statement: i3 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicInteger: int get()>() 
(define-const var1258 var1106 (var3166_getUrl/-275947851 (cast-from-var3920-to-var3166 var2371))) ; Statement: $r4 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var676 String (getApplication/-536601276 var1258)) ; Statement: r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getApplication()>() 
(define-const var2929 ClassObject (var3920_getInterface/-1171900879 var2371)) ; Statement: $r6 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>() 
(assert true)
(define-const var1359 String (getName/-1958580599 var2929)) ; Statement: r7 = virtualinvoke $r6.<java.lang.Class: java.lang.String getName()>() 
(define-const var325 String (var3063_getMethodName/-516674313 var3679)) ; Statement: r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r2) 
(define-const var2327 var1106 (var3166_getUrl/-275947851 (cast-from-var3920-to-var3166 var2371))) ; Statement: $r9 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2021 String (getGroup/1342955253 var2327)) ; Statement: r10 = virtualinvoke $r9.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(define-const var2903 var1106 (var3166_getUrl/-275947851 (cast-from-var3920-to-var3166 var2371))) ; Statement: $r11 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2078 String (getVersion/189836348 var2903)) ; Statement: r12 = virtualinvoke $r11.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(define-const var1671 String "consumer") ; Statement: $r15 = "consumer" 
(define-const var3216 var1106 (var3166_getUrl/-275947851 (cast-from-var3920-to-var3166 var2371))) ; Statement: $r13 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3115 String (getSide/-520240817 var3216)) ; Statement: $r14 = virtualinvoke $r13.<org.apache.dubbo.common.URL: java.lang.String getSide()>() 
(assert true)
(define-const var3189 Bool (= var1671 var3115)) ; Statement: $z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>($r14) 
 ; Statement: if $z0 == 0 goto $r16 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert (not (= (ite var3189 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1383 Int 0) ; Statement: i5 = 0 
(define-const var647 String "provider") ; Statement: r27 = "provider" 
(define-const var1571 var1106 (var3166_getUrl/-275947851 (cast-from-var3920-to-var3166 var2371))) ; Statement: $r26 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var94 String (getAddress/-2093578336 var1571)) ; Statement: r28 = virtualinvoke $r26.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
 ; Statement: goto [?= r29 = ""] 
(assert true) ; Non Conditional
(define-const var2227 String "") ; Statement: r29 = "" 
(define-const var2378 String "") ; Statement: r30 = "" 
(define-const var184 String (var1562_getAttachment/-2134772037 var3679 "input")) ; Statement: $r18 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("input") 
 ; Statement: if $r18 == null goto (branch) 
(assert (= var184 null-String)) ; Cond: $r18 == null 
 ; Statement: if r19 == null goto $r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert (= var2993 null-var3220)) ; Cond: r19 == null 
(define-const var2088 var3835 var3835-init) ; Statement: $r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(define-const var1345 String var31_getLocalHost/-1653363627) ; Statement: $r24 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
(define-const var456 Int var1383) ; Statement: $i4 = i5 
(define-const var2833 String String-init) ; Statement: $r31 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2833)) ; Statement: specialinvoke $r31.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2833!1 String)
(assert (= var2833!1 ""))
(assert true)
(define-const var3547 String (append/672562846 var2833!1 var1359)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var2833!2 String)
(assert (= var2833!2 (str.++ var2833!1 var1359)))
(assert true)
(define-const var573 String (append/672562846 var3547 "/")) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var3547!1 String)
(assert (= var3547!1 (str.++ var3547 "/")))
(assert true)
(define-const var2501 String (append/672562846 var573 var325)) ; Statement: $r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var573!1 String)
(assert (= var573!1 (str.++ var573 var325)))
(assert true)
(define-const var3042 String (toString/-2075883882 var2501)) ; Statement: $r23 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var652 (Array Int String) arr-String-init) ; Statement: $r35 = newarray (java.lang.String)[22] 
(declare-const var652!1 (Array Int String))
(assert (not (= var652!1 null-__Array__Int__String__)))
(assert (= (select var652!1 0) "application")) ; Statement: $r35[0] = "application" 
(declare-const var652!2 (Array Int String))
(assert (not (= var652!2 null-__Array__Int__String__)))
(assert (= (select var652!2 1) var676)) ; Statement: $r35[1] = r5 
(declare-const var652!3 (Array Int String))
(assert (not (= var652!3 null-__Array__Int__String__)))
(assert (= (select var652!3 2) "interface")) ; Statement: $r35[2] = "interface" 
(declare-const var652!4 (Array Int String))
(assert (not (= var652!4 null-__Array__Int__String__)))
(assert (= (select var652!4 3) var1359)) ; Statement: $r35[3] = r7 
(declare-const var652!5 (Array Int String))
(assert (not (= var652!5 null-__Array__Int__String__)))
(assert (= (select var652!5 4) "method")) ; Statement: $r35[4] = "method" 
(declare-const var652!6 (Array Int String))
(assert (not (= var652!6 null-__Array__Int__String__)))
(assert (= (select var652!6 5) var325)) ; Statement: $r35[5] = r8 
(declare-const var652!7 (Array Int String))
(assert (not (= var652!7 null-__Array__Int__String__)))
(assert (= (select var652!7 6) var647)) ; Statement: $r35[6] = r27 
(declare-const var652!8 (Array Int String))
(assert (not (= var652!8 null-__Array__Int__String__)))
(assert (= (select var652!8 7) var94)) ; Statement: $r35[7] = r28 
 ; Statement: if z1 == 0 goto $r36 = "success" 
(assert (not (= (ite var2318 1 0) 0))) ; Negate: Cond: z1 == 0  
(define-const var1957 String "failure") ; Statement: $r36 = "failure" 
 ; Statement: goto [?= $r35[8] = $r36] 
(assert true) ; Non Conditional
(declare-const var652!9 (Array Int String))
(assert (not (= var652!9 null-__Array__Int__String__)))
(assert (= (select var652!9 8) var1957)) ; Statement: $r35[8] = $r36 
(declare-const var652!10 (Array Int String))
(assert (not (= var652!10 null-__Array__Int__String__)))
(assert (= (select var652!10 9) "1")) ; Statement: $r35[9] = "1" 
(declare-const var652!11 (Array Int String))
(assert (not (= var652!11 null-__Array__Int__String__)))
(assert (= (select var652!11 10) "elapsed")) ; Statement: $r35[10] = "elapsed" 
(define-const var334 String (String_valueOf/-107395227 var215)) ; Statement: $r21 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l2) 
(declare-const var652!12 (Array Int String))
(assert (not (= var652!12 null-__Array__Int__String__)))
(assert (= (select var652!12 11) var334)) ; Statement: $r35[11] = $r21 
(declare-const var652!13 (Array Int String))
(assert (not (= var652!13 null-__Array__Int__String__)))
(assert (= (select var652!13 12) "concurrent")) ; Statement: $r35[12] = "concurrent" 
(define-const var1704 String (String_valueOf/1240665136 var3052)) ; Statement: $r22 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i3) 
(declare-const var652!14 (Array Int String))
(assert (not (= var652!14 null-__Array__Int__String__)))
(assert (= (select var652!14 13) var1704)) ; Statement: $r35[13] = $r22 
(declare-const var652!15 (Array Int String))
(assert (not (= var652!15 null-__Array__Int__String__)))
(assert (= (select var652!15 14) "input")) ; Statement: $r35[14] = "input" 
(declare-const var652!16 (Array Int String))
(assert (not (= var652!16 null-__Array__Int__String__)))
(assert (= (select var652!16 15) var2227)) ; Statement: $r35[15] = r29 
(declare-const var652!17 (Array Int String))
(assert (not (= var652!17 null-__Array__Int__String__)))
(assert (= (select var652!17 16) "output")) ; Statement: $r35[16] = "output" 
(declare-const var652!18 (Array Int String))
(assert (not (= var652!18 null-__Array__Int__String__)))
(assert (= (select var652!18 17) var2378)) ; Statement: $r35[17] = r30 
(declare-const var652!19 (Array Int String))
(assert (not (= var652!19 null-__Array__Int__String__)))
(assert (= (select var652!19 18) "group")) ; Statement: $r35[18] = "group" 
(declare-const var652!20 (Array Int String))
(assert (not (= var652!20 null-__Array__Int__String__)))
(assert (= (select var652!20 19) var2021)) ; Statement: $r35[19] = r10 
(declare-const var652!21 (Array Int String))
(assert (not (= var652!21 null-__Array__Int__String__)))
(assert (= (select var652!21 20) "version")) ; Statement: $r35[20] = "version" 
(declare-const var652!22 (Array Int String))
(assert (not (= var652!22 null-__Array__Int__String__)))
(assert (= (select var652!22 21) var2078)) ; Statement: $r35[21] = r12 
(assert true)
;(assert (<init>/-737007403 var2088 "count" var1345 var456 var3042 var652!22)) ; Statement: specialinvoke $r20.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.lang.String[])>("count", $r24, $i4, $r23, $r35) 

(declare-const var2088!1 var3835)
(declare-const var2427 String)
(declare-const var1345!1 String)
(declare-const var456!1 Int)
(declare-const var3042!1 String)
(declare-const var652!23 (Array Int String))
 ; Statement: return $r20 
(check-sat)
; {var3190_currentTimeMillis/630293680=([], long), getConcurrent/-1808556126=([org.apache.dubbo.monitor.support.MonitorFilter, org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation], java.util.concurrent.atomic.AtomicInteger), get/-785596375=([java.util.concurrent.atomic.AtomicInteger], int), var3166_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3920-to-var3166=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getApplication/-536601276=([org.apache.dubbo.common.URL], java.lang.String), var3920_getInterface/-1171900879=([org.apache.dubbo.rpc.Invoker], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), var3063_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), getSide/-520240817=([org.apache.dubbo.common.URL], java.lang.String), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), var1562_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var3835-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), var31_getLocalHost/-1653363627=([], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), arr-String-init=([], java.lang.String[]), String_valueOf/-107395227=([long], java.lang.String), String_valueOf/1240665136=([int], java.lang.String), <init>/-737007403=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, int, java.lang.String, java.lang.String[]], void)}
; {var330=org.apache.dubbo.monitor.support.MonitorFilter, var2315=r0, var3920=org.apache.dubbo.rpc.Invoker, var2371=r1, var1562=org.apache.dubbo.rpc.Invocation, var3679=r2, var3220=org.apache.dubbo.rpc.Result, var2993=r19, var3873=r17, var2393=null_type, var392=l0, var2318=z1, var3190=java.lang.System, var2809=$l1, var215=l2, var1692=java.util.concurrent.atomic.AtomicInteger, var940=$r3, var3052=i3, var1106=org.apache.dubbo.common.URL, var3166=org.apache.dubbo.common.Node, var1258=$r4, var676=r5, var2929=$r6, var1359=r7, var3063=org.apache.dubbo.rpc.support.RpcUtils, var325=r8, var2327=$r9, var2021=r10, var2903=$r11, var2078=r12, var1671=$r15, var3216=$r13, var3115=$r14, var3189=$z0, var1383=i5, var647=r27, var1571=$r26, var94=r28, var2227=r29, var2378=r30, var184=$r18, var3835=org.apache.dubbo.common.url.component.ServiceConfigURL, var2088=$r20, var31=org.apache.dubbo.common.utils.NetUtils, var1345=$r24, var456=$i4, var2833=$r31, var3547=$r32, var573=$r33, var2501=$r34, var3042=$r23, var652=$r35, var1957=$r36, var334=$r21, var1704=$r22, var2427="count"}
; {org.apache.dubbo.monitor.support.MonitorFilter=var330, r0=var2315, org.apache.dubbo.rpc.Invoker=var3920, r1=var2371, org.apache.dubbo.rpc.Invocation=var1562, r2=var3679, org.apache.dubbo.rpc.Result=var3220, r19=var2993, r17=var3873, null_type=var2393, l0=var392, z1=var2318, java.lang.System=var3190, $l1=var2809, l2=var215, java.util.concurrent.atomic.AtomicInteger=var1692, $r3=var940, i3=var3052, org.apache.dubbo.common.URL=var1106, org.apache.dubbo.common.Node=var3166, $r4=var1258, r5=var676, $r6=var2929, r7=var1359, org.apache.dubbo.rpc.support.RpcUtils=var3063, r8=var325, $r9=var2327, r10=var2021, $r11=var2903, r12=var2078, $r15=var1671, $r13=var3216, $r14=var3115, $z0=var3189, i5=var1383, r27=var647, $r26=var1571, r28=var94, r29=var2227, r30=var2378, $r18=var184, org.apache.dubbo.common.url.component.ServiceConfigURL=var3835, $r20=var2088, org.apache.dubbo.common.utils.NetUtils=var31, $r24=var1345, $i4=var456, $r31=var2833, $r32=var3547, $r33=var573, $r34=var2501, $r23=var3042, $r35=var652, $r36=var1957, $r21=var334, $r22=var1704, "count"=var2427}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String valueOf(long)>;	<java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String valueOf(long)>": 1,"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.monitor.support.MonitorFilter;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r2 := @parameter1: org.apache.dubbo.rpc.Invocation;	r19 := @parameter2: org.apache.dubbo.rpc.Result;	r17 := @parameter3: java.lang.String;	l0 := @parameter4: long;	z1 := @parameter5: boolean;	$l1 = staticinvoke <java.lang.System: long currentTimeMillis()>();	l2 = $l1 - l0;	$r3 = specialinvoke r0.<org.apache.dubbo.monitor.support.MonitorFilter: java.util.concurrent.atomic.AtomicInteger getConcurrent(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r2);	i3 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicInteger: int get()>();	$r4 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getApplication()>();	$r6 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>();	r7 = virtualinvoke $r6.<java.lang.Class: java.lang.String getName()>();	r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r2);	$r9 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r10 = virtualinvoke $r9.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r11 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r12 = virtualinvoke $r11.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$r15 = "consumer";	$r13 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r14 = virtualinvoke $r13.<org.apache.dubbo.common.URL: java.lang.String getSide()>();	$z0 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>($r14);	if $z0 == 0 goto $r16 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	i5 = 0;	r27 = "provider";	$r26 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r28 = virtualinvoke $r26.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	goto [?= r29 = ""];	r29 = "";	r30 = "";	$r18 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("input");	if $r18 == null goto (branch);	if r19 == null goto $r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r20 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r24 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	$i4 = i5;	$r31 = new java.lang.StringBuilder;	specialinvoke $r31.<java.lang.StringBuilder: void <init>()>();	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r23 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.String toString()>();	$r35 = newarray (java.lang.String)[22];	$r35[0] = "application";	$r35[1] = r5;	$r35[2] = "interface";	$r35[3] = r7;	$r35[4] = "method";	$r35[5] = r8;	$r35[6] = r27;	$r35[7] = r28;	if z1 == 0 goto $r36 = "success";	$r36 = "failure";	goto [?= $r35[8] = $r36];	$r35[8] = $r36;	$r35[9] = "1";	$r35[10] = "elapsed";	$r21 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l2);	$r35[11] = $r21;	$r35[12] = "concurrent";	$r22 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i3);	$r35[13] = $r22;	$r35[14] = "input";	$r35[15] = r29;	$r35[16] = "output";	$r35[17] = r30;	$r35[18] = "group";	$r35[19] = r10;	$r35[20] = "version";	$r35[21] = r12;	specialinvoke $r20.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.lang.String[])>("count", $r24, $i4, $r23, $r35);	return $r20
;block_num 7