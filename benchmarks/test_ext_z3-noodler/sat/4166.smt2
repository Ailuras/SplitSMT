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

(declare-sort var832 0)
(declare-sort var814 0)
(declare-sort var226 0)
(declare-sort var3187 0)
(declare-sort var2114 0)
(declare-sort var553 0)
(declare-sort var3161 0)
(declare-sort var1969 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var226) void)
(declare-fun cast-from-var832-to-var226 (var832) var226)
(declare-fun var3187-init () var3187)
(declare-fun <init>/2144030345 (var3187 Int) void)
(declare-fun mThreadNum/1074567745 (var832) var3187)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun mPrefix/1074567745 (var832) String)
(declare-fun mDaemon/1074567745 (var832) Bool)
(declare-fun var553_getSecurityManager/-1522955590 () var2114)
(declare-fun var3161_currentThread/-1037784612 () var3161)
(declare-fun getThreadGroup/821017279 (var3161) var1969)
(declare-fun mGroup/1074567745 (var832) var1969)
(declare-const null-var832 var832)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const null-var2114 var2114)
(declare-const var2609 var832) ; Statement: r0 := @this: org.apache.dubbo.common.utils.NamedThreadFactory 
(assert (not (= var2609 null-var832)))
(declare-const var1299 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1299 null-String)))
(declare-const var2057 Bool) ; Statement: z0 := @parameter1: boolean 
(assert (not (= var2057 null-Bool)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var832-to-var226 var2609))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2609!1 var832)
(define-const var2501 var3187 var3187-init) ; Statement: $r1 = new java.util.concurrent.atomic.AtomicInteger 
(assert true)
;(assert (<init>/2144030345 var2501 1)) ; Statement: specialinvoke $r1.<java.util.concurrent.atomic.AtomicInteger: void <init>(int)>(1) 

(declare-const var2501!1 var3187)
(declare-const var1183 Int)
(declare-const var2609!2 var832)
(assert (not (= var2609!2 null-var832)))
(assert (= (mThreadNum/1074567745 var2609!2) var2501!1)) ; Statement: r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.util.concurrent.atomic.AtomicInteger mThreadNum> = $r1 
(define-const var3608 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3608)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3608!1 String)
(assert (= var3608!1 ""))
(assert true)
(define-const var3811 String (append/672562846 var3608!1 var1299)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var3608!2 String)
(assert (= var3608!2 (str.++ var3608!1 var1299)))
(assert true)
(define-const var1119 String (append/672562846 var3811 "-thread-")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-thread-") 
(declare-const var3811!1 String)
(assert (= var3811!1 (str.++ var3811 "-thread-")))
(assert true)
(define-const var3994 String (toString/-2075883882 var1119)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var2609!3 var832)
(assert (not (= var2609!3 null-var832)))
(assert (= (mPrefix/1074567745 var2609!3) var3994)) ; Statement: r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.String mPrefix> = $r6 
(declare-const var2609!4 var832)
(assert (not (= var2609!4 null-var832)))
(assert (= (mDaemon/1074567745 var2609!4) var2057)) ; Statement: r0.<org.apache.dubbo.common.utils.NamedThreadFactory: boolean mDaemon> = z0 
(define-const var3745 var2114 var553_getSecurityManager/-1522955590) ; Statement: r7 = staticinvoke <java.lang.System: java.lang.SecurityManager getSecurityManager()>() 
 ; Statement: if r7 != null goto $r9 = virtualinvoke r7.<java.lang.SecurityManager: java.lang.ThreadGroup getThreadGroup()>() 
(assert (not (not (= var3745 null-var2114)))) ; Negate: Cond: r7 != null  
(define-const var3535 var3161 var3161_currentThread/-1037784612) ; Statement: $r8 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>() 
(assert true)
(define-const var1468 var1969 (getThreadGroup/821017279 var3535)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.Thread: java.lang.ThreadGroup getThreadGroup()>() 
 ; Statement: goto [?= r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.ThreadGroup mGroup> = $r9] 
(assert true) ; Non Conditional
(declare-const var2609!5 var832)
(assert (not (= var2609!5 null-var832)))
(assert (= (mGroup/1074567745 var2609!5) var1468)) ; Statement: r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.ThreadGroup mGroup> = $r9 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var832-to-var226=([org.apache.dubbo.common.utils.NamedThreadFactory], java.lang.Object), var3187-init=([], java.util.concurrent.atomic.AtomicInteger), <init>/2144030345=([java.util.concurrent.atomic.AtomicInteger, int], void), mThreadNum/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], java.util.concurrent.atomic.AtomicInteger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), mPrefix/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], java.lang.String), mDaemon/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], boolean), var553_getSecurityManager/-1522955590=([], java.lang.SecurityManager), var3161_currentThread/-1037784612=([], java.lang.Thread), getThreadGroup/821017279=([java.lang.Thread], java.lang.ThreadGroup), mGroup/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], java.lang.ThreadGroup)}
; {var832=org.apache.dubbo.common.utils.NamedThreadFactory, var2609=r0, var1299=r3, var814=null_type, var2057=z0, var226=java.lang.Object, var3187=java.util.concurrent.atomic.AtomicInteger, var2501=$r1, var1183=1, var3608=$r2, var3811=$r4, var1119=$r5, var3994=$r6, var2114=java.lang.SecurityManager, var553=java.lang.System, var3745=r7, var3161=java.lang.Thread, var3535=$r8, var1969=java.lang.ThreadGroup, var1468=$r9}
; {org.apache.dubbo.common.utils.NamedThreadFactory=var832, r0=var2609, r3=var1299, null_type=var814, z0=var2057, java.lang.Object=var226, java.util.concurrent.atomic.AtomicInteger=var3187, $r1=var2501, 1=var1183, $r2=var3608, $r4=var3811, $r5=var1119, $r6=var3994, java.lang.SecurityManager=var2114, java.lang.System=var553, r7=var3745, java.lang.Thread=var3161, $r8=var3535, java.lang.ThreadGroup=var1969, $r9=var1468}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.NamedThreadFactory;	r3 := @parameter0: java.lang.String;	z0 := @parameter1: boolean;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.concurrent.atomic.AtomicInteger;	specialinvoke $r1.<java.util.concurrent.atomic.AtomicInteger: void <init>(int)>(1);	r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.util.concurrent.atomic.AtomicInteger mThreadNum> = $r1;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-thread-");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.String mPrefix> = $r6;	r0.<org.apache.dubbo.common.utils.NamedThreadFactory: boolean mDaemon> = z0;	r7 = staticinvoke <java.lang.System: java.lang.SecurityManager getSecurityManager()>();	if r7 != null goto $r9 = virtualinvoke r7.<java.lang.SecurityManager: java.lang.ThreadGroup getThreadGroup()>();	$r8 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>();	$r9 = virtualinvoke $r8.<java.lang.Thread: java.lang.ThreadGroup getThreadGroup()>();	goto [?= r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.ThreadGroup mGroup> = $r9];	r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.ThreadGroup mGroup> = $r9;	return
;block_num 3