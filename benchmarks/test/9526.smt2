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

(declare-sort var3469 0)
(declare-sort var217 0)
(declare-sort var3712 0)
(declare-sort var1261 0)
(declare-sort var111 0)
(declare-sort var1544 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun this$0/-834817842 (var3469) var217)
(declare-fun <init>/-279557996 (var3712) void)
(declare-fun cast-from-var3469-to-var3712 (var3469) var3712)
(declare-fun running/-834817842 (var3469) Bool)
(declare-fun var1261-init () var1261)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var217_access$000/-119130229 () var111)
(declare-fun getAndIncrement/-721914959 (var111) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1250801909 (var1261 var1544 String) void)
(declare-fun cast-from-var3469-to-var1544 (var3469) var1544)
(declare-fun expirerThread/-834817842 (var3469) var1261)
(declare-fun setDaemon/1897296623 (var1261 Bool) void)
(declare-const null-var3469 var3469)
(declare-const null-var217 var217)
(declare-const var3042 var3469) ; Statement: r0 := @this: org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread 
(assert (not (= var3042 null-var3469)))
(declare-const var2063 var217) ; Statement: r1 := @parameter0: org.apache.dubbo.cache.support.expiring.ExpiringMap 
(assert (not (= var2063 null-var217)))
(declare-const var3042!1 var3469)
(assert (not (= var3042!1 null-var3469)))
(assert (= (this$0/-834817842 var3042!1) var2063)) ; Statement: r0.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: org.apache.dubbo.cache.support.expiring.ExpiringMap this$0> = r1 
(assert true)
;(assert (<init>/-279557996 (cast-from-var3469-to-var3712 var3042!1))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3042!2 var3469)
(declare-const var3042!3 var3469)
(assert (not (= var3042!3 null-var3469)))
(assert (= (running/-834817842 var3042!3) (ite (= 1 0) true false))) ; Statement: r0.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: boolean running> = 0 
(define-const var725 var1261 var1261-init) ; Statement: $r2 = new java.lang.Thread 
(define-const var3482 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3482)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3482!1 String)
(assert (= var3482!1 ""))
(assert true)
(define-const var3365 String (append/672562846 var3482!1 "ExpiryMapExpire-")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ExpiryMapExpire-") 
(declare-const var3482!2 String)
(assert (= var3482!2 (str.++ var3482!1 "ExpiryMapExpire-")))
(define-const var911 var111 var217_access$000/-119130229) ; Statement: $r4 = staticinvoke <org.apache.dubbo.cache.support.expiring.ExpiringMap: java.util.concurrent.atomic.AtomicInteger access$000()>() 
(assert true)
(define-const var3305 Int (getAndIncrement/-721914959 var911)) ; Statement: $i0 = virtualinvoke $r4.<java.util.concurrent.atomic.AtomicInteger: int getAndIncrement()>() 
(assert true)
(define-const var1007 String (append/-1001720160 var3365 var3305)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3365!1 String)
(assert (str.prefixof var3365 var3365!1))
(assert true)
(define-const var2293 String (toString/-2075883882 var1007)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1250801909 var725 (cast-from-var3469-to-var1544 var3042!3) var2293)) ; Statement: specialinvoke $r2.<java.lang.Thread: void <init>(java.lang.Runnable,java.lang.String)>(r0, $r7) 

(declare-const var725!1 var1261)
(declare-const var3042!4 var3469)
(declare-const var2293!1 String)
(declare-const var3042!5 var3469)
(assert (not (= var3042!5 null-var3469)))
(assert (= (expirerThread/-834817842 var3042!5) var725!1)) ; Statement: r0.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: java.lang.Thread expirerThread> = $r2 
(define-const var615 var1261 (expirerThread/-834817842 var3042!5)) ; Statement: $r8 = r0.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: java.lang.Thread expirerThread> 
(assert true)
;(assert (setDaemon/1897296623 var615 (ite (= 1 1) true false))) ; Statement: virtualinvoke $r8.<java.lang.Thread: void setDaemon(boolean)>(1) 

(declare-const var615!1 var1261)
(declare-const var1128 Int)
 ; Statement: return 
(check-sat)
; {this$0/-834817842=([org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread], org.apache.dubbo.cache.support.expiring.ExpiringMap), <init>/-279557996=([java.lang.Object], void), cast-from-var3469-to-var3712=([org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread], java.lang.Object), running/-834817842=([org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread], boolean), var1261-init=([], java.lang.Thread), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var217_access$000/-119130229=([], java.util.concurrent.atomic.AtomicInteger), getAndIncrement/-721914959=([java.util.concurrent.atomic.AtomicInteger], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1250801909=([java.lang.Thread, java.lang.Runnable, java.lang.String], void), cast-from-var3469-to-var1544=([org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread], java.lang.Runnable), expirerThread/-834817842=([org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread], java.lang.Thread), setDaemon/1897296623=([java.lang.Thread, boolean], void)}
; {var3469=org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread, var3042=r0, var217=org.apache.dubbo.cache.support.expiring.ExpiringMap, var2063=r1, var3712=java.lang.Object, var1261=java.lang.Thread, var725=$r2, var3482=$r3, var3365=$r5, var111=java.util.concurrent.atomic.AtomicInteger, var911=$r4, var3305=$i0, var1007=$r6, var2293=$r7, var1544=java.lang.Runnable, var615=$r8, var1128=1}
; {org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread=var3469, r0=var3042, org.apache.dubbo.cache.support.expiring.ExpiringMap=var217, r1=var2063, java.lang.Object=var3712, java.lang.Thread=var1261, $r2=var725, $r3=var3482, $r5=var3365, java.util.concurrent.atomic.AtomicInteger=var111, $r4=var911, $i0=var3305, $r6=var1007, $r7=var2293, java.lang.Runnable=var1544, $r8=var615, 1=var1128}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread;	r1 := @parameter0: org.apache.dubbo.cache.support.expiring.ExpiringMap;	r0.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: org.apache.dubbo.cache.support.expiring.ExpiringMap this$0> = r1;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: boolean running> = 0;	$r2 = new java.lang.Thread;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ExpiryMapExpire-");	$r4 = staticinvoke <org.apache.dubbo.cache.support.expiring.ExpiringMap: java.util.concurrent.atomic.AtomicInteger access$000()>();	$i0 = virtualinvoke $r4.<java.util.concurrent.atomic.AtomicInteger: int getAndIncrement()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.Thread: void <init>(java.lang.Runnable,java.lang.String)>(r0, $r7);	r0.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: java.lang.Thread expirerThread> = $r2;	$r8 = r0.<org.apache.dubbo.cache.support.expiring.ExpiringMap$ExpireThread: java.lang.Thread expirerThread>;	virtualinvoke $r8.<java.lang.Thread: void setDaemon(boolean)>(1);	return
;block_num 1