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

(declare-sort var1327 0)
(declare-sort var227 0)
(declare-sort var2738 0)
(declare-sort var3242 0)
(declare-sort var2436 0)
(declare-sort var15 0)
(declare-sort var2962 0)
(declare-sort var346 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun mPrefix/1074567745 (var2738) String)
(declare-fun cast-from-var1327-to-var2738 (var1327) var2738)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun mThreadNum/1074567745 (var2738) var3242)
(declare-fun getAndIncrement/-721914959 (var3242) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2436-init () var2436)
(declare-fun mGroup/1074567745 (var2738) var15)
(declare-fun var2962_Wrap/-1421561093 (var227) var227)
(declare-fun <init>/-586403771 (var2436 var15 var227 String Int) void)
(declare-fun mDaemon/1074567745 (var2738) Bool)
(declare-fun setDaemon/1897296623 (var346 Bool) void)
(declare-fun cast-from-var2436-to-var346 (var2436) var346)
(declare-const null-var1327 var1327)
(declare-const null-var227 var227)
(declare-const var2719 var1327) ; Statement: r1 := @this: org.apache.dubbo.common.threadlocal.NamedInternalThreadFactory 
(assert (not (= var2719 null-var1327)))
(declare-const var265 var227) ; Statement: r8 := @parameter0: java.lang.Runnable 
(assert (not (= var265 null-var227)))
(define-const var744 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var744)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var744!1 String)
(assert (= var744!1 ""))
(define-const var785 String (mPrefix/1074567745 (cast-from-var1327-to-var2738 var2719))) ; Statement: $r2 = r1.<org.apache.dubbo.common.threadlocal.NamedInternalThreadFactory: java.lang.String mPrefix> 
(assert true)
(define-const var3537 String (append/672562846 var744!1 var785)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var744!2 String)
(assert (= var744!2 (str.++ var744!1 var785)))
(define-const var549 var3242 (mThreadNum/1074567745 (cast-from-var1327-to-var2738 var2719))) ; Statement: $r3 = r1.<org.apache.dubbo.common.threadlocal.NamedInternalThreadFactory: java.util.concurrent.atomic.AtomicInteger mThreadNum> 
(assert true)
(define-const var902 Int (getAndIncrement/-721914959 var549)) ; Statement: $i0 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicInteger: int getAndIncrement()>() 
(assert true)
(define-const var3631 String (append/-1001720160 var3537 var902)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3537!1 String)
(assert (str.prefixof var3537 var3537!1))
(assert true)
(define-const var3448 String (toString/-2075883882 var3631)) ; Statement: r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var411 var2436 var2436-init) ; Statement: $r7 = new org.apache.dubbo.common.threadlocal.InternalThread 
(define-const var432 var15 (mGroup/1074567745 (cast-from-var1327-to-var2738 var2719))) ; Statement: $r9 = r1.<org.apache.dubbo.common.threadlocal.NamedInternalThreadFactory: java.lang.ThreadGroup mGroup> 
(define-const var1390 var227 (var2962_Wrap/-1421561093 var265)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.common.threadlocal.InternalRunnable: java.lang.Runnable Wrap(java.lang.Runnable)>(r8) 
(assert true)
;(assert (<init>/-586403771 var411 var432 var1390 var3448 0)) ; Statement: specialinvoke $r7.<org.apache.dubbo.common.threadlocal.InternalThread: void <init>(java.lang.ThreadGroup,java.lang.Runnable,java.lang.String,long)>($r9, $r10, r6, 0L) 

(declare-const var411!1 var2436)
(declare-const var432!1 var15)
(declare-const var1390!1 var227)
(declare-const var3448!1 String)
(declare-const var2369 Int)
(define-const var1786 Bool (mDaemon/1074567745 (cast-from-var1327-to-var2738 var2719))) ; Statement: $z0 = r1.<org.apache.dubbo.common.threadlocal.NamedInternalThreadFactory: boolean mDaemon> 
(assert true)
;(assert (setDaemon/1897296623 (cast-from-var2436-to-var346 var411!1) var1786)) ; Statement: virtualinvoke $r7.<org.apache.dubbo.common.threadlocal.InternalThread: void setDaemon(boolean)>($z0) 

(declare-const var411!2 var2436)
(declare-const var1786!1 Bool)
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), mPrefix/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], java.lang.String), cast-from-var1327-to-var2738=([org.apache.dubbo.common.threadlocal.NamedInternalThreadFactory], org.apache.dubbo.common.utils.NamedThreadFactory), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), mThreadNum/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], java.util.concurrent.atomic.AtomicInteger), getAndIncrement/-721914959=([java.util.concurrent.atomic.AtomicInteger], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2436-init=([], org.apache.dubbo.common.threadlocal.InternalThread), mGroup/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], java.lang.ThreadGroup), var2962_Wrap/-1421561093=([java.lang.Runnable], java.lang.Runnable), <init>/-586403771=([org.apache.dubbo.common.threadlocal.InternalThread, java.lang.ThreadGroup, java.lang.Runnable, java.lang.String, long], void), mDaemon/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], boolean), setDaemon/1897296623=([java.lang.Thread, boolean], void), cast-from-var2436-to-var346=([org.apache.dubbo.common.threadlocal.InternalThread], java.lang.Thread)}
; {var1327=org.apache.dubbo.common.threadlocal.NamedInternalThreadFactory, var2719=r1, var227=java.lang.Runnable, var265=r8, var744=$r0, var2738=org.apache.dubbo.common.utils.NamedThreadFactory, var785=$r2, var3537=$r4, var3242=java.util.concurrent.atomic.AtomicInteger, var549=$r3, var902=$i0, var3631=$r5, var3448=r6, var2436=org.apache.dubbo.common.threadlocal.InternalThread, var411=$r7, var15=java.lang.ThreadGroup, var432=$r9, var2962=org.apache.dubbo.common.threadlocal.InternalRunnable, var1390=$r10, var2369=0L, var1786=$z0, var346=java.lang.Thread}
; {org.apache.dubbo.common.threadlocal.NamedInternalThreadFactory=var1327, r1=var2719, java.lang.Runnable=var227, r8=var265, $r0=var744, org.apache.dubbo.common.utils.NamedThreadFactory=var2738, $r2=var785, $r4=var3537, java.util.concurrent.atomic.AtomicInteger=var3242, $r3=var549, $i0=var902, $r5=var3631, r6=var3448, org.apache.dubbo.common.threadlocal.InternalThread=var2436, $r7=var411, java.lang.ThreadGroup=var15, $r9=var432, org.apache.dubbo.common.threadlocal.InternalRunnable=var2962, $r10=var1390, 0L=var2369, $z0=var1786, java.lang.Thread=var346}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.threadlocal.NamedInternalThreadFactory;	r8 := @parameter0: java.lang.Runnable;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.common.threadlocal.NamedInternalThreadFactory: java.lang.String mPrefix>;	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r3 = r1.<org.apache.dubbo.common.threadlocal.NamedInternalThreadFactory: java.util.concurrent.atomic.AtomicInteger mThreadNum>;	$i0 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicInteger: int getAndIncrement()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = new org.apache.dubbo.common.threadlocal.InternalThread;	$r9 = r1.<org.apache.dubbo.common.threadlocal.NamedInternalThreadFactory: java.lang.ThreadGroup mGroup>;	$r10 = staticinvoke <org.apache.dubbo.common.threadlocal.InternalRunnable: java.lang.Runnable Wrap(java.lang.Runnable)>(r8);	specialinvoke $r7.<org.apache.dubbo.common.threadlocal.InternalThread: void <init>(java.lang.ThreadGroup,java.lang.Runnable,java.lang.String,long)>($r9, $r10, r6, 0L);	$z0 = r1.<org.apache.dubbo.common.threadlocal.NamedInternalThreadFactory: boolean mDaemon>;	virtualinvoke $r7.<org.apache.dubbo.common.threadlocal.InternalThread: void setDaemon(boolean)>($z0);	return $r7
;block_num 1