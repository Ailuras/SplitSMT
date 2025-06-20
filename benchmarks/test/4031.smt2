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

(declare-sort var3826 0)
(declare-sort var1292 0)
(declare-sort var2094 0)
(declare-sort var2326 0)
(declare-sort var2984 0)
(declare-sort var3679 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1292_nanoTime/-1409780067 () Int)
(declare-fun deadline/3524090 (var3826) Int)
(declare-fun timer/3524090 (var3826) var2094)
(declare-fun var2094_access$200/1205748579 (var2094) Int)
(declare-fun getClass/1258963082 (var2326) ClassObject)
(declare-fun cast-from-var3826-to-var2326 (var3826) var2326)
(declare-fun var2984_simpleClassName/822183132 (ClassObject) String)
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun append/-901862667 (String Int) String)
(declare-fun isCancelled/-1388742766 (var3826) Bool)
(declare-fun task/221530008 (var3826) var3679)
(declare-fun append/-1031950772 (String var2326) String)
(declare-fun cast-from-var3679-to-var2326 (var3679) var2326)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3826 var3826)
(declare-const var3383 var3826) ; Statement: r0 := @this: org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout 
(assert (not (= var3383 null-var3826)))
(define-const var141 Int var1292_nanoTime/-1409780067) ; Statement: l0 = staticinvoke <java.lang.System: long nanoTime()>() 
(define-const var2296 Int (deadline/3524090 var3383)) ; Statement: $l1 = r0.<org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout: long deadline> 
(define-const var2193 Int (- var2296 var141)) ; Statement: $l3 = $l1 - l0 
(define-const var1570 var2094 (timer/3524090 var3383)) ; Statement: $r1 = r0.<org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout: org.apache.dubbo.common.timer.HashedWheelTimer timer> 
(define-const var1895 Int (var2094_access$200/1205748579 var1570)) ; Statement: $l2 = staticinvoke <org.apache.dubbo.common.timer.HashedWheelTimer: long access$200(org.apache.dubbo.common.timer.HashedWheelTimer)>($r1) 
(define-const var70 Int (+ var2193 var1895)) ; Statement: l4 = $l3 + $l2 
(assert true)
(define-const var1308 ClassObject (getClass/1258963082 (cast-from-var3826-to-var2326 var3383))) ; Statement: $r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(define-const var2932 String (var2984_simpleClassName/822183132 var1308)) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String simpleClassName(java.lang.Class)>($r2) 
(define-const var376 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var376 192)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>(int)>(192) 

(declare-const var376!1 String)
(declare-const var3684 Int)
(assert true)
(define-const var1443 String (append/672562846 var376!1 var2932)) ; Statement: $r5 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var376!2 String)
(assert (= var376!2 (str.++ var376!1 var2932)))
(assert true)
(define-const var1007 String (append/-1166366385 var1443 40)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var1443!1 String)
(assert (str.prefixof var1443 var1443!1))
(assert true)
(define-const var1928 String (append/672562846 var1007 "deadline: ")) ; Statement: r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("deadline: ") 
(declare-const var1007!1 String)
(assert (= var1007!1 (str.++ var1007 "deadline: ")))
(define-const var2674 Int (ite (> var70 0) 1 (ite (< var70 0) -1 0))) ; Statement: $b5 = l4 cmp 0L 
(define-const var1669 Int (cast-from-Int-to-Int var2674)) ; Statement: $i8 = (int) $b5 
 ; Statement: if $i8 <= 0 goto $b6 = l4 cmp 0L 
(assert (not (<= var1669 0))) ; Negate: Cond: $i8 <= 0  
(assert true)
(define-const var3285 String (append/-901862667 var1928 var70)) ; Statement: $r14 = virtualinvoke r7.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l4) 
(declare-const var1928!1 String)
(assert (str.prefixof var1928 var1928!1))
(assert true)
;(assert (append/672562846 var3285 " ns later")) ; Statement: virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ns later") 
(declare-const var3285!1 String)
(assert (= var3285!1 (str.++ var3285 " ns later")))
 ; Statement: goto [?= $z0 = virtualinvoke r0.<org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout: boolean isCancelled()>()] 
(assert true) ; Non Conditional
(assert true)
(define-const var2713 Bool (isCancelled/-1388742766 var3383)) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout: boolean isCancelled()>() 
 ; Statement: if $z0 == 0 goto $r9 = virtualinvoke r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", task: ") 
(assert (= (ite var2713 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3720 String (append/672562846 var1928!1 ", task: ")) ; Statement: $r9 = virtualinvoke r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", task: ") 
(declare-const var1928!2 String)
(assert (= var1928!2 (str.++ var1928!1 ", task: ")))
(assert true)
(define-const var3688 var3679 (task/221530008 var3383)) ; Statement: $r8 = virtualinvoke r0.<org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout: org.apache.dubbo.common.timer.TimerTask task()>() 
(assert true)
(define-const var2383 String (append/-1031950772 var3720 (cast-from-var3679-to-var2326 var3688))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var3720!1 String)
(assert (str.prefixof var3720 var3720!1))
(assert true)
(define-const var905 String (append/-1166366385 var2383 41)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var2383!1 String)
(assert (str.prefixof var2383 var2383!1))
(assert true)
(define-const var2215 String (toString/-2075883882 var905)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {var1292_nanoTime/-1409780067=([], long), deadline/3524090=([org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout], long), timer/3524090=([org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout], org.apache.dubbo.common.timer.HashedWheelTimer), var2094_access$200/1205748579=([org.apache.dubbo.common.timer.HashedWheelTimer], long), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3826-to-var2326=([org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout], java.lang.Object), var2984_simpleClassName/822183132=([java.lang.Class], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), cast-from-Int-to-Int=([byte], int), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), isCancelled/-1388742766=([org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout], boolean), task/221530008=([org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout], org.apache.dubbo.common.timer.TimerTask), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3679-to-var2326=([org.apache.dubbo.common.timer.TimerTask], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3826=org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout, var3383=r0, var1292=java.lang.System, var141=l0, var2296=$l1, var2193=$l3, var2094=org.apache.dubbo.common.timer.HashedWheelTimer, var1570=$r1, var1895=$l2, var70=l4, var2326=java.lang.Object, var1308=$r2, var2984=org.apache.dubbo.common.utils.ClassUtils, var2932=r3, var376=$r15, var3684=192, var1443=$r5, var1007=$r6, var1928=r7, var2674=$b5, var1669=$i8, var3285=$r14, var2713=$z0, var3720=$r9, var3679=org.apache.dubbo.common.timer.TimerTask, var3688=$r8, var2383=$r10, var905=$r11, var2215=$r12}
; {org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout=var3826, r0=var3383, java.lang.System=var1292, l0=var141, $l1=var2296, $l3=var2193, org.apache.dubbo.common.timer.HashedWheelTimer=var2094, $r1=var1570, $l2=var1895, l4=var70, java.lang.Object=var2326, $r2=var1308, org.apache.dubbo.common.utils.ClassUtils=var2984, r3=var2932, $r15=var376, 192=var3684, $r5=var1443, $r6=var1007, r7=var1928, $b5=var2674, $i8=var1669, $r14=var3285, $z0=var2713, $r9=var3720, org.apache.dubbo.common.timer.TimerTask=var3679, $r8=var3688, $r10=var2383, $r11=var905, $r12=var2215}
;seq <java.lang.StringBuilder: void <init>(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout;	l0 = staticinvoke <java.lang.System: long nanoTime()>();	$l1 = r0.<org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout: long deadline>;	$l3 = $l1 - l0;	$r1 = r0.<org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout: org.apache.dubbo.common.timer.HashedWheelTimer timer>;	$l2 = staticinvoke <org.apache.dubbo.common.timer.HashedWheelTimer: long access$200(org.apache.dubbo.common.timer.HashedWheelTimer)>($r1);	l4 = $l3 + $l2;	$r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	r3 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String simpleClassName(java.lang.Class)>($r2);	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>(int)>(192);	$r5 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("deadline: ");	$b5 = l4 cmp 0L;	$i8 = (int) $b5;	if $i8 <= 0 goto $b6 = l4 cmp 0L;	$r14 = virtualinvoke r7.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l4);	virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ns later");	goto [?= $z0 = virtualinvoke r0.<org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout: boolean isCancelled()>()];	$z0 = virtualinvoke r0.<org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout: boolean isCancelled()>();	if $z0 == 0 goto $r9 = virtualinvoke r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", task: ");	$r9 = virtualinvoke r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", task: ");	$r8 = virtualinvoke r0.<org.apache.dubbo.common.timer.HashedWheelTimer$HashedWheelTimeout: org.apache.dubbo.common.timer.TimerTask task()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 4