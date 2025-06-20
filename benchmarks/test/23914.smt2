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

(declare-sort var548 0)
(declare-sort var840 0)
(declare-sort var2285 0)
(declare-sort var2069 0)
(declare-sort var1516 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var840_currentTimeMillis/630293680 () Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2285-init () var2285)
(declare-fun <init>/-1862704206 (var2285 String) void)
(declare-fun var2069-init () var2069)
(declare-fun start/870816197 (var548) Int)
(declare-fun <init>/593337323 (var2069 Int) void)
(declare-fun format/215566421 (var1516 var2069) String)
(declare-fun cast-from-var2285-to-var1516 (var2285) var1516)
(declare-fun timeout/870816197 (var548) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun serviceName/870816197 (var548) String)
(declare-fun methodName/870816197 (var548) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var548 var548)
(declare-const var605 var548) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.DeadlineFuture 
(assert (not (= var605 null-var548)))
(define-const var1080 Int var840_currentTimeMillis/630293680) ; Statement: l0 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var2788 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2788)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2788!1 String)
(assert (= var2788!1 ""))
(assert true)
(define-const var3108 String (append/672562846 var2788!1 "Waiting server-side response timeout by scan timer. start time: ")) ; Statement: $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Waiting server-side response timeout by scan timer. start time: ") 
(declare-const var2788!2 String)
(assert (= var2788!2 (str.++ var2788!1 "Waiting server-side response timeout by scan timer. start time: ")))
(define-const var2717 var2285 var2285-init) ; Statement: $r1 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var2717 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r1.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var2717!1 var2285)
(declare-const var2670 String)
(define-const var1131 var2069 var2069-init) ; Statement: $r2 = new java.util.Date 
(define-const var1185 Int (start/870816197 var605)) ; Statement: $l1 = r3.<org.apache.dubbo.rpc.protocol.tri.DeadlineFuture: long start> 
(assert true)
;(assert (<init>/593337323 var1131 var1185)) ; Statement: specialinvoke $r2.<java.util.Date: void <init>(long)>($l1) 

(declare-const var1131!1 var2069)
(declare-const var1185!1 Int)
(assert true)
(define-const var1643 String (format/215566421 (cast-from-var2285-to-var1516 var2717!1) var1131!1)) ; Statement: $r4 = virtualinvoke $r1.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r2) 
(assert true)
(define-const var1533 String (append/672562846 var3108 var1643)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var3108!1 String)
(assert (= var3108!1 (str.++ var3108 var1643)))
(assert true)
(define-const var1893 String (append/672562846 var1533 ", end time: ")) ; Statement: $r10 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ") 
(declare-const var1533!1 String)
(assert (= var1533!1 (str.++ var1533 ", end time: ")))
(define-const var1895 var2285 var2285-init) ; Statement: $r7 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var1895 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r7.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var1895!1 var2285)
(declare-const var2670!1 String)
(define-const var498 var2069 var2069-init) ; Statement: $r8 = new java.util.Date 
(assert true)
;(assert (<init>/593337323 var498 var1080)) ; Statement: specialinvoke $r8.<java.util.Date: void <init>(long)>(l0) 

(declare-const var498!1 var2069)
(declare-const var1080!1 Int)
(assert true)
(define-const var3257 String (format/215566421 (cast-from-var2285-to-var1516 var1895!1) var498!1)) ; Statement: $r9 = virtualinvoke $r7.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r8) 
(assert true)
(define-const var3493 String (append/672562846 var1893 var3257)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var1893!1 String)
(assert (= var1893!1 (str.++ var1893 var3257)))
(assert true)
(define-const var3380 String (append/672562846 var3493 ", timeout: ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", timeout: ") 
(declare-const var3493!1 String)
(assert (= var3493!1 (str.++ var3493 ", timeout: ")))
(define-const var3598 Int (timeout/870816197 var605)) ; Statement: $i2 = r3.<org.apache.dubbo.rpc.protocol.tri.DeadlineFuture: int timeout> 
(assert true)
(define-const var1219 String (append/-1001720160 var3380 var3598)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var3380!1 String)
(assert (str.prefixof var3380 var3380!1))
(assert true)
(define-const var2481 String (append/672562846 var1219 " ms, service: ")) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, service: ") 
(declare-const var1219!1 String)
(assert (= var1219!1 (str.++ var1219 " ms, service: ")))
(define-const var2195 String (serviceName/870816197 var605)) ; Statement: $r14 = r3.<org.apache.dubbo.rpc.protocol.tri.DeadlineFuture: java.lang.String serviceName> 
(assert true)
(define-const var168 String (append/672562846 var2481 var2195)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var2481!1 String)
(assert (= var2481!1 (str.++ var2481 var2195)))
(assert true)
(define-const var1217 String (append/672562846 var168 ", method: ")) ; Statement: $r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method: ") 
(declare-const var168!1 String)
(assert (= var168!1 (str.++ var168 ", method: ")))
(define-const var1485 String (methodName/870816197 var605)) ; Statement: $r17 = r3.<org.apache.dubbo.rpc.protocol.tri.DeadlineFuture: java.lang.String methodName> 
(assert true)
(define-const var2944 String (append/672562846 var1217 var1485)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var1217!1 String)
(assert (= var1217!1 (str.++ var1217 var1485)))
(assert true)
(define-const var1836 String (toString/-2075883882 var2944)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r20 
(check-sat)
; {var840_currentTimeMillis/630293680=([], long), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2285-init=([], java.text.SimpleDateFormat), <init>/-1862704206=([java.text.SimpleDateFormat, java.lang.String], void), var2069-init=([], java.util.Date), start/870816197=([org.apache.dubbo.rpc.protocol.tri.DeadlineFuture], long), <init>/593337323=([java.util.Date, long], void), format/215566421=([java.text.DateFormat, java.util.Date], java.lang.String), cast-from-var2285-to-var1516=([java.text.SimpleDateFormat], java.text.DateFormat), timeout/870816197=([org.apache.dubbo.rpc.protocol.tri.DeadlineFuture], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), serviceName/870816197=([org.apache.dubbo.rpc.protocol.tri.DeadlineFuture], java.lang.String), methodName/870816197=([org.apache.dubbo.rpc.protocol.tri.DeadlineFuture], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var548=org.apache.dubbo.rpc.protocol.tri.DeadlineFuture, var605=r3, var840=java.lang.System, var1080=l0, var2788=$r0, var3108=$r5, var2285=java.text.SimpleDateFormat, var2717=$r1, var2670="yyyy-MM-dd HH:mm:ss.SSS", var2069=java.util.Date, var1131=$r2, var1185=$l1, var1516=java.text.DateFormat, var1643=$r4, var1533=$r6, var1893=$r10, var1895=$r7, var498=$r8, var3257=$r9, var3493=$r11, var3380=$r12, var3598=$i2, var1219=$r13, var2481=$r15, var2195=$r14, var168=$r16, var1217=$r18, var1485=$r17, var2944=$r19, var1836=$r20}
; {org.apache.dubbo.rpc.protocol.tri.DeadlineFuture=var548, r3=var605, java.lang.System=var840, l0=var1080, $r0=var2788, $r5=var3108, java.text.SimpleDateFormat=var2285, $r1=var2717, "yyyy-MM-dd HH:mm:ss.SSS"=var2670, java.util.Date=var2069, $r2=var1131, $l1=var1185, java.text.DateFormat=var1516, $r4=var1643, $r6=var1533, $r10=var1893, $r7=var1895, $r8=var498, $r9=var3257, $r11=var3493, $r12=var3380, $i2=var3598, $r13=var1219, $r15=var2481, $r14=var2195, $r16=var168, $r18=var1217, $r17=var1485, $r19=var2944, $r20=var1836}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 9,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.DeadlineFuture;	l0 = staticinvoke <java.lang.System: long currentTimeMillis()>();	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Waiting server-side response timeout by scan timer. start time: ");	$r1 = new java.text.SimpleDateFormat;	specialinvoke $r1.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r2 = new java.util.Date;	$l1 = r3.<org.apache.dubbo.rpc.protocol.tri.DeadlineFuture: long start>;	specialinvoke $r2.<java.util.Date: void <init>(long)>($l1);	$r4 = virtualinvoke $r1.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r2);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r10 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ");	$r7 = new java.text.SimpleDateFormat;	specialinvoke $r7.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r8 = new java.util.Date;	specialinvoke $r8.<java.util.Date: void <init>(long)>(l0);	$r9 = virtualinvoke $r7.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", timeout: ");	$i2 = r3.<org.apache.dubbo.rpc.protocol.tri.DeadlineFuture: int timeout>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, service: ");	$r14 = r3.<org.apache.dubbo.rpc.protocol.tri.DeadlineFuture: java.lang.String serviceName>;	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method: ");	$r17 = r3.<org.apache.dubbo.rpc.protocol.tri.DeadlineFuture: java.lang.String methodName>;	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	return $r20
;block_num 1