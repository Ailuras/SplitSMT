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

(declare-sort var2667 0)
(declare-sort var2647 0)
(declare-sort var99 0)
(declare-sort var921 0)
(declare-sort var3113 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun mPrefix/1074567745 (var2667) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun mThreadNum/1074567745 (var2667) var99)
(declare-fun getAndIncrement/-721914959 (var99) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var921-init () var921)
(declare-fun mGroup/1074567745 (var2667) var3113)
(declare-fun <init>/-295685614 (var921 var3113 var2647 String Int) void)
(declare-fun mDaemon/1074567745 (var2667) Bool)
(declare-fun setDaemon/1897296623 (var921 Bool) void)
(declare-const null-var2667 var2667)
(declare-const null-var2647 var2647)
(declare-const var895 var2667) ; Statement: r1 := @this: org.apache.dubbo.common.utils.NamedThreadFactory 
(assert (not (= var895 null-var2667)))
(declare-const var3610 var2647) ; Statement: r8 := @parameter0: java.lang.Runnable 
(assert (not (= var3610 null-var2647)))
(define-const var2612 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2612)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2612!1 String)
(assert (= var2612!1 ""))
(define-const var460 String (mPrefix/1074567745 var895)) ; Statement: $r2 = r1.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.String mPrefix> 
(assert true)
(define-const var3877 String (append/672562846 var2612!1 var460)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2612!2 String)
(assert (= var2612!2 (str.++ var2612!1 var460)))
(define-const var1462 var99 (mThreadNum/1074567745 var895)) ; Statement: $r3 = r1.<org.apache.dubbo.common.utils.NamedThreadFactory: java.util.concurrent.atomic.AtomicInteger mThreadNum> 
(assert true)
(define-const var1951 Int (getAndIncrement/-721914959 var1462)) ; Statement: $i0 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicInteger: int getAndIncrement()>() 
(assert true)
(define-const var3282 String (append/-1001720160 var3877 var1951)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3877!1 String)
(assert (str.prefixof var3877 var3877!1))
(assert true)
(define-const var3009 String (toString/-2075883882 var3282)) ; Statement: r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2975 var921 var921-init) ; Statement: $r7 = new java.lang.Thread 
(define-const var138 var3113 (mGroup/1074567745 var895)) ; Statement: $r9 = r1.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.ThreadGroup mGroup> 
(assert true)
;(assert (<init>/-295685614 var2975 var138 var3610 var3009 0)) ; Statement: specialinvoke $r7.<java.lang.Thread: void <init>(java.lang.ThreadGroup,java.lang.Runnable,java.lang.String,long)>($r9, r8, r6, 0L) 

(declare-const var2975!1 var921)
(declare-const var138!1 var3113)
(declare-const var3610!1 var2647)
(declare-const var3009!1 String)
(declare-const var2427 Int)
(define-const var621 Bool (mDaemon/1074567745 var895)) ; Statement: $z0 = r1.<org.apache.dubbo.common.utils.NamedThreadFactory: boolean mDaemon> 
(assert true)
;(assert (setDaemon/1897296623 var2975!1 var621)) ; Statement: virtualinvoke $r7.<java.lang.Thread: void setDaemon(boolean)>($z0) 

(declare-const var2975!2 var921)
(declare-const var621!1 Bool)
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), mPrefix/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), mThreadNum/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], java.util.concurrent.atomic.AtomicInteger), getAndIncrement/-721914959=([java.util.concurrent.atomic.AtomicInteger], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var921-init=([], java.lang.Thread), mGroup/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], java.lang.ThreadGroup), <init>/-295685614=([java.lang.Thread, java.lang.ThreadGroup, java.lang.Runnable, java.lang.String, long], void), mDaemon/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], boolean), setDaemon/1897296623=([java.lang.Thread, boolean], void)}
; {var2667=org.apache.dubbo.common.utils.NamedThreadFactory, var895=r1, var2647=java.lang.Runnable, var3610=r8, var2612=$r0, var460=$r2, var3877=$r4, var99=java.util.concurrent.atomic.AtomicInteger, var1462=$r3, var1951=$i0, var3282=$r5, var3009=r6, var921=java.lang.Thread, var2975=$r7, var3113=java.lang.ThreadGroup, var138=$r9, var2427=0L, var621=$z0}
; {org.apache.dubbo.common.utils.NamedThreadFactory=var2667, r1=var895, java.lang.Runnable=var2647, r8=var3610, $r0=var2612, $r2=var460, $r4=var3877, java.util.concurrent.atomic.AtomicInteger=var99, $r3=var1462, $i0=var1951, $r5=var3282, r6=var3009, java.lang.Thread=var921, $r7=var2975, java.lang.ThreadGroup=var3113, $r9=var138, 0L=var2427, $z0=var621}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.utils.NamedThreadFactory;	r8 := @parameter0: java.lang.Runnable;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.String mPrefix>;	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r3 = r1.<org.apache.dubbo.common.utils.NamedThreadFactory: java.util.concurrent.atomic.AtomicInteger mThreadNum>;	$i0 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicInteger: int getAndIncrement()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = new java.lang.Thread;	$r9 = r1.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.ThreadGroup mGroup>;	specialinvoke $r7.<java.lang.Thread: void <init>(java.lang.ThreadGroup,java.lang.Runnable,java.lang.String,long)>($r9, r8, r6, 0L);	$z0 = r1.<org.apache.dubbo.common.utils.NamedThreadFactory: boolean mDaemon>;	virtualinvoke $r7.<java.lang.Thread: void setDaemon(boolean)>($z0);	return $r7
;block_num 1