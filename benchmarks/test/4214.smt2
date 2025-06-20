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

(declare-sort var3183 0)
(declare-sort var1703 0)
(declare-sort var632 0)
(declare-sort var1348 0)
(declare-sort var2117 0)
(declare-sort var314 0)
(declare-sort var2231 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var632) void)
(declare-fun cast-from-var3183-to-var632 (var3183) var632)
(declare-fun var1348-init () var1348)
(declare-fun <init>/2144030345 (var1348 Int) void)
(declare-fun mThreadNum/1074567745 (var3183) var1348)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun mPrefix/1074567745 (var3183) String)
(declare-fun mDaemon/1074567745 (var3183) Bool)
(declare-fun var314_getSecurityManager/-1522955590 () var2117)
(declare-fun getThreadGroup/929545980 (var2117) var2231)
(declare-fun mGroup/1074567745 (var3183) var2231)
(declare-const null-var3183 var3183)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const null-var2117 var2117)
(declare-const var317 var3183) ; Statement: r0 := @this: org.apache.dubbo.common.utils.NamedThreadFactory 
(assert (not (= var317 null-var3183)))
(declare-const var3536 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var3536 null-String)))
(declare-const var2500 Bool) ; Statement: z0 := @parameter1: boolean 
(assert (not (= var2500 null-Bool)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3183-to-var632 var317))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var317!1 var3183)
(define-const var1930 var1348 var1348-init) ; Statement: $r1 = new java.util.concurrent.atomic.AtomicInteger 
(assert true)
;(assert (<init>/2144030345 var1930 1)) ; Statement: specialinvoke $r1.<java.util.concurrent.atomic.AtomicInteger: void <init>(int)>(1) 

(declare-const var1930!1 var1348)
(declare-const var3371 Int)
(declare-const var317!2 var3183)
(assert (not (= var317!2 null-var3183)))
(assert (= (mThreadNum/1074567745 var317!2) var1930!1)) ; Statement: r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.util.concurrent.atomic.AtomicInteger mThreadNum> = $r1 
(define-const var1997 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1997)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1997!1 String)
(assert (= var1997!1 ""))
(assert true)
(define-const var978 String (append/672562846 var1997!1 var3536)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var1997!2 String)
(assert (= var1997!2 (str.++ var1997!1 var3536)))
(assert true)
(define-const var1802 String (append/672562846 var978 "-thread-")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-thread-") 
(declare-const var978!1 String)
(assert (= var978!1 (str.++ var978 "-thread-")))
(assert true)
(define-const var2652 String (toString/-2075883882 var1802)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var317!3 var3183)
(assert (not (= var317!3 null-var3183)))
(assert (= (mPrefix/1074567745 var317!3) var2652)) ; Statement: r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.String mPrefix> = $r6 
(declare-const var317!4 var3183)
(assert (not (= var317!4 null-var3183)))
(assert (= (mDaemon/1074567745 var317!4) var2500)) ; Statement: r0.<org.apache.dubbo.common.utils.NamedThreadFactory: boolean mDaemon> = z0 
(define-const var1005 var2117 var314_getSecurityManager/-1522955590) ; Statement: r7 = staticinvoke <java.lang.System: java.lang.SecurityManager getSecurityManager()>() 
 ; Statement: if r7 != null goto $r9 = virtualinvoke r7.<java.lang.SecurityManager: java.lang.ThreadGroup getThreadGroup()>() 
(assert (not (= var1005 null-var2117))) ; Cond: r7 != null 
(assert true)
(define-const var2597 var2231 (getThreadGroup/929545980 var1005)) ; Statement: $r9 = virtualinvoke r7.<java.lang.SecurityManager: java.lang.ThreadGroup getThreadGroup()>() 
(assert true) ; Non Conditional
(declare-const var317!5 var3183)
(assert (not (= var317!5 null-var3183)))
(assert (= (mGroup/1074567745 var317!5) var2597)) ; Statement: r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.ThreadGroup mGroup> = $r9 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3183-to-var632=([org.apache.dubbo.common.utils.NamedThreadFactory], java.lang.Object), var1348-init=([], java.util.concurrent.atomic.AtomicInteger), <init>/2144030345=([java.util.concurrent.atomic.AtomicInteger, int], void), mThreadNum/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], java.util.concurrent.atomic.AtomicInteger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), mPrefix/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], java.lang.String), mDaemon/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], boolean), var314_getSecurityManager/-1522955590=([], java.lang.SecurityManager), getThreadGroup/929545980=([java.lang.SecurityManager], java.lang.ThreadGroup), mGroup/1074567745=([org.apache.dubbo.common.utils.NamedThreadFactory], java.lang.ThreadGroup)}
; {var3183=org.apache.dubbo.common.utils.NamedThreadFactory, var317=r0, var3536=r3, var1703=null_type, var2500=z0, var632=java.lang.Object, var1348=java.util.concurrent.atomic.AtomicInteger, var1930=$r1, var3371=1, var1997=$r2, var978=$r4, var1802=$r5, var2652=$r6, var2117=java.lang.SecurityManager, var314=java.lang.System, var1005=r7, var2231=java.lang.ThreadGroup, var2597=$r9}
; {org.apache.dubbo.common.utils.NamedThreadFactory=var3183, r0=var317, r3=var3536, null_type=var1703, z0=var2500, java.lang.Object=var632, java.util.concurrent.atomic.AtomicInteger=var1348, $r1=var1930, 1=var3371, $r2=var1997, $r4=var978, $r5=var1802, $r6=var2652, java.lang.SecurityManager=var2117, java.lang.System=var314, r7=var1005, java.lang.ThreadGroup=var2231, $r9=var2597}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.NamedThreadFactory;	r3 := @parameter0: java.lang.String;	z0 := @parameter1: boolean;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.concurrent.atomic.AtomicInteger;	specialinvoke $r1.<java.util.concurrent.atomic.AtomicInteger: void <init>(int)>(1);	r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.util.concurrent.atomic.AtomicInteger mThreadNum> = $r1;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-thread-");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.String mPrefix> = $r6;	r0.<org.apache.dubbo.common.utils.NamedThreadFactory: boolean mDaemon> = z0;	r7 = staticinvoke <java.lang.System: java.lang.SecurityManager getSecurityManager()>();	if r7 != null goto $r9 = virtualinvoke r7.<java.lang.SecurityManager: java.lang.ThreadGroup getThreadGroup()>();	$r9 = virtualinvoke r7.<java.lang.SecurityManager: java.lang.ThreadGroup getThreadGroup()>();	r0.<org.apache.dubbo.common.utils.NamedThreadFactory: java.lang.ThreadGroup mGroup> = $r9;	return
;block_num 3