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

(declare-sort var440 0)
(declare-sort var2898 0)
(declare-sort var2005 0)
(declare-sort var2242 0)
(declare-sort var1951 0)
(declare-sort var3440 0)
(declare-sort var3966 0)
(declare-sort var1927 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var2242-init () (Array Int var2242))
(declare-fun threadName/898879186 (var440) String)
(declare-fun cast-from-String-to-var2242 (String) var2242)
(declare-fun getPoolSize/1118117717 (var2005) Int)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var2242 (Int) var2242)
(declare-fun getActiveCount/-419351137 (var2005) Int)
(declare-fun getCorePoolSize/-304825418 (var2005) Int)
(declare-fun getMaximumPoolSize/-1348340533 (var2005) Int)
(declare-fun getLargestPoolSize/936720015 (var2005) Int)
(declare-fun getTaskCount/-151846113 (var2005) Int)
(declare-fun Int_valueOf/-1102777585 (Int) Int)
(declare-fun getCompletedTaskCount/-1142502030 (var2005) Int)
(declare-fun isShutdown/-1417095861 (var2005) Bool)
(declare-fun var1951_valueOf/1602327315 (Bool) var1951)
(declare-fun cast-from-var1951-to-var2242 (var1951) var2242)
(declare-fun isTerminated/1455795550 (var2005) Bool)
(declare-fun isTerminating/-1989351109 (var2005) Bool)
(declare-fun url/898879186 (var440) var3440)
(declare-fun getProtocol/491749358 (var3440) String)
(declare-fun getIp/-49850945 (var3440) String)
(declare-fun getPort/20614931 (var3440) Int)
(declare-fun String_format/1339386452 (String (Array Int var2242)) String)
(declare-fun var3966_warn/1431914100 (var3966 String String String String) void)
(declare-fun toString/1090915316 (var1951) String)
(declare-fun getParameter/506106603 (var3440 String String) String)
(declare-fun var1951_parseBoolean/746105335 (String) Bool)
(declare-fun dispatchThreadPoolExhaustedEvent/-1068144455 (var440 String) void)
(declare-fun var1927-init () var1927)
(declare-fun <init>/-886329222 (var1927 String) void)
(declare-const null-var440 var440)
(declare-const null-var2898 var2898)
(declare-const null-var2005 var2005)
(declare-const null-__Array__Int__var2242__ (Array Int var2242))
(declare-const var440-logger var3966)
(declare-const var1951-TRUE var1951)
(declare-const var2113 var440) ; Statement: r1 := @this: org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport 
(assert (not (= var2113 null-var440)))
(declare-const var2000 var2898) ; Statement: r27 := @parameter0: java.lang.Runnable 
(assert (not (= var2000 null-var2898)))
(declare-const var1191 var2005) ; Statement: r3 := @parameter1: java.util.concurrent.ThreadPoolExecutor 
(assert (not (= var1191 null-var2005)))
(define-const var799 (Array Int var2242) arr-var2242-init) ; Statement: $r0 = newarray (java.lang.Object)[14] 
(define-const var885 String (threadName/898879186 var2113)) ; Statement: $r2 = r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: java.lang.String threadName> 
(declare-const var799!1 (Array Int var2242))
(assert (not (= var799!1 null-__Array__Int__var2242__)))
(assert (= (select var799!1 0) (cast-from-String-to-var2242 var885))) ; Statement: $r0[0] = $r2 
(assert true)
(define-const var3706 Int (getPoolSize/1118117717 var1191)) ; Statement: $i0 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: int getPoolSize()>() 
(define-const var1778 Int (Int_valueOf/-1371140006 var3706)) ; Statement: $r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i0) 
(declare-const var799!2 (Array Int var2242))
(assert (not (= var799!2 null-__Array__Int__var2242__)))
(assert (= (select var799!2 1) (cast-from-Int-to-var2242 var1778))) ; Statement: $r0[1] = $r4 
(assert true)
(define-const var1998 Int (getActiveCount/-419351137 var1191)) ; Statement: $i1 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: int getActiveCount()>() 
(define-const var341 Int (Int_valueOf/-1371140006 var1998)) ; Statement: $r5 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i1) 
(declare-const var799!3 (Array Int var2242))
(assert (not (= var799!3 null-__Array__Int__var2242__)))
(assert (= (select var799!3 2) (cast-from-Int-to-var2242 var341))) ; Statement: $r0[2] = $r5 
(assert true)
(define-const var145 Int (getCorePoolSize/-304825418 var1191)) ; Statement: $i2 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: int getCorePoolSize()>() 
(define-const var1850 Int (Int_valueOf/-1371140006 var145)) ; Statement: $r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i2) 
(declare-const var799!4 (Array Int var2242))
(assert (not (= var799!4 null-__Array__Int__var2242__)))
(assert (= (select var799!4 3) (cast-from-Int-to-var2242 var1850))) ; Statement: $r0[3] = $r6 
(assert true)
(define-const var2888 Int (getMaximumPoolSize/-1348340533 var1191)) ; Statement: $i3 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: int getMaximumPoolSize()>() 
(define-const var3599 Int (Int_valueOf/-1371140006 var2888)) ; Statement: $r7 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i3) 
(declare-const var799!5 (Array Int var2242))
(assert (not (= var799!5 null-__Array__Int__var2242__)))
(assert (= (select var799!5 4) (cast-from-Int-to-var2242 var3599))) ; Statement: $r0[4] = $r7 
(assert true)
(define-const var1440 Int (getLargestPoolSize/936720015 var1191)) ; Statement: $i4 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: int getLargestPoolSize()>() 
(define-const var3561 Int (Int_valueOf/-1371140006 var1440)) ; Statement: $r8 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i4) 
(declare-const var799!6 (Array Int var2242))
(assert (not (= var799!6 null-__Array__Int__var2242__)))
(assert (= (select var799!6 5) (cast-from-Int-to-var2242 var3561))) ; Statement: $r0[5] = $r8 
(assert true)
(define-const var2086 Int (getTaskCount/-151846113 var1191)) ; Statement: $l5 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: long getTaskCount()>() 
(define-const var3947 Int (Int_valueOf/-1102777585 var2086)) ; Statement: $r9 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l5) 
(declare-const var799!7 (Array Int var2242))
(assert (not (= var799!7 null-__Array__Int__var2242__)))
(assert (= (select var799!7 6) (cast-from-Int-to-var2242 var3947))) ; Statement: $r0[6] = $r9 
(assert true)
(define-const var1589 Int (getCompletedTaskCount/-1142502030 var1191)) ; Statement: $l6 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: long getCompletedTaskCount()>() 
(define-const var733 Int (Int_valueOf/-1102777585 var1589)) ; Statement: $r10 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l6) 
(declare-const var799!8 (Array Int var2242))
(assert (not (= var799!8 null-__Array__Int__var2242__)))
(assert (= (select var799!8 7) (cast-from-Int-to-var2242 var733))) ; Statement: $r0[7] = $r10 
(assert true)
(define-const var2962 Bool (isShutdown/-1417095861 var1191)) ; Statement: $z0 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: boolean isShutdown()>() 
(define-const var2337 var1951 (var1951_valueOf/1602327315 var2962)) ; Statement: $r11 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>($z0) 
(declare-const var799!9 (Array Int var2242))
(assert (not (= var799!9 null-__Array__Int__var2242__)))
(assert (= (select var799!9 8) (cast-from-var1951-to-var2242 var2337))) ; Statement: $r0[8] = $r11 
(assert true)
(define-const var3787 Bool (isTerminated/1455795550 var1191)) ; Statement: $z1 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: boolean isTerminated()>() 
(define-const var3316 var1951 (var1951_valueOf/1602327315 var3787)) ; Statement: $r12 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>($z1) 
(declare-const var799!10 (Array Int var2242))
(assert (not (= var799!10 null-__Array__Int__var2242__)))
(assert (= (select var799!10 9) (cast-from-var1951-to-var2242 var3316))) ; Statement: $r0[9] = $r12 
(assert true)
(define-const var3122 Bool (isTerminating/-1989351109 var1191)) ; Statement: $z2 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: boolean isTerminating()>() 
(define-const var1509 var1951 (var1951_valueOf/1602327315 var3122)) ; Statement: $r13 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>($z2) 
(declare-const var799!11 (Array Int var2242))
(assert (not (= var799!11 null-__Array__Int__var2242__)))
(assert (= (select var799!11 10) (cast-from-var1951-to-var2242 var1509))) ; Statement: $r0[10] = $r13 
(define-const var321 var3440 (url/898879186 var2113)) ; Statement: $r14 = r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var1960 String (getProtocol/491749358 var321)) ; Statement: $r15 = virtualinvoke $r14.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(declare-const var799!12 (Array Int var2242))
(assert (not (= var799!12 null-__Array__Int__var2242__)))
(assert (= (select var799!12 11) (cast-from-String-to-var2242 var1960))) ; Statement: $r0[11] = $r15 
(define-const var1742 var3440 (url/898879186 var2113)) ; Statement: $r16 = r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var2115 String (getIp/-49850945 var1742)) ; Statement: $r17 = virtualinvoke $r16.<org.apache.dubbo.common.URL: java.lang.String getIp()>() 
(declare-const var799!13 (Array Int var2242))
(assert (not (= var799!13 null-__Array__Int__var2242__)))
(assert (= (select var799!13 12) (cast-from-String-to-var2242 var2115))) ; Statement: $r0[12] = $r17 
(define-const var1391 var3440 (url/898879186 var2113)) ; Statement: $r18 = r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var3888 Int (getPort/20614931 var1391)) ; Statement: $i7 = virtualinvoke $r18.<org.apache.dubbo.common.URL: int getPort()>() 
(define-const var1187 Int (Int_valueOf/-1371140006 var3888)) ; Statement: $r19 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i7) 
(declare-const var799!14 (Array Int var2242))
(assert (not (= var799!14 null-__Array__Int__var2242__)))
(assert (= (select var799!14 13) (cast-from-Int-to-var2242 var1187))) ; Statement: $r0[13] = $r19 
(define-const var164 String (String_format/1339386452 "Thread pool is EXHAUSTED! Thread Name: %s, Pool Size: %d (active: %d, core: %d, max: %d, largest: %d), Task: %d (completed: %d), Executor status:(isShutdown:%s, isTerminated:%s, isTerminating:%s), in %s://%s:%d!" var799!14)) ; Statement: r20 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Thread pool is EXHAUSTED! Thread Name: %s, Pool Size: %d (active: %d, core: %d, max: %d, largest: %d), Task: %d (completed: %d), Executor status:(isShutdown:%s, isTerminated:%s, isTerminating:%s), in %s://%s:%d!", $r0) 
(define-const var3570 var3966 var440-logger) ; Statement: $r21 = <org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var3966_warn/1431914100 var3570 "0-1" "too much client requesting provider" "" var164)) ; Statement: interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("0-1", "too much client requesting provider", "", r20) 

(declare-const var3570!1 var3966)
(declare-const var1483 String)
(declare-const var1329 String)
(declare-const var3831 String)
(declare-const var164!1 String)
(define-const var1271 var3440 (url/898879186 var2113)) ; Statement: $r23 = r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.URL url> 
(define-const var2592 var1951 var1951-TRUE) ; Statement: $r22 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert true)
(define-const var1481 String (toString/1090915316 var2592)) ; Statement: $r24 = virtualinvoke $r22.<java.lang.Boolean: java.lang.String toString()>() 
(assert true)
(define-const var1320 String (getParameter/506106603 var1271 "dump.enable" var1481)) ; Statement: $r25 = virtualinvoke $r23.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("dump.enable", $r24) 
(define-const var2588 Bool (var1951_parseBoolean/746105335 var1320)) ; Statement: $z3 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>($r25) 
 ; Statement: if $z3 == 0 goto virtualinvoke r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: void dispatchThreadPoolExhaustedEvent(java.lang.String)>(r20) 
(assert (= (ite var2588 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
;(assert (dispatchThreadPoolExhaustedEvent/-1068144455 var2113 var164!1)) ; Statement: virtualinvoke r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: void dispatchThreadPoolExhaustedEvent(java.lang.String)>(r20) 

(declare-const var2113!1 var440)
(declare-const var164!2 String)
(define-const var162 var1927 var1927-init) ; Statement: $r26 = new java.util.concurrent.RejectedExecutionException 
(assert true)
;(assert (<init>/-886329222 var162 var164!2)) ; Statement: specialinvoke $r26.<java.util.concurrent.RejectedExecutionException: void <init>(java.lang.String)>(r20) 

(declare-const var162!1 var1927)
(declare-const var164!3 String)
 ; Statement: throw $r26 
(check-sat)
; {arr-var2242-init=([], java.lang.Object[]), threadName/898879186=([org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport], java.lang.String), cast-from-String-to-var2242=([java.lang.String], java.lang.Object), getPoolSize/1118117717=([java.util.concurrent.ThreadPoolExecutor], int), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var2242=([java.lang.Integer], java.lang.Object), getActiveCount/-419351137=([java.util.concurrent.ThreadPoolExecutor], int), getCorePoolSize/-304825418=([java.util.concurrent.ThreadPoolExecutor], int), getMaximumPoolSize/-1348340533=([java.util.concurrent.ThreadPoolExecutor], int), getLargestPoolSize/936720015=([java.util.concurrent.ThreadPoolExecutor], int), getTaskCount/-151846113=([java.util.concurrent.ThreadPoolExecutor], long), Int_valueOf/-1102777585=([long], java.lang.Long), getCompletedTaskCount/-1142502030=([java.util.concurrent.ThreadPoolExecutor], long), isShutdown/-1417095861=([java.util.concurrent.ThreadPoolExecutor], boolean), var1951_valueOf/1602327315=([boolean], java.lang.Boolean), cast-from-var1951-to-var2242=([java.lang.Boolean], java.lang.Object), isTerminated/1455795550=([java.util.concurrent.ThreadPoolExecutor], boolean), isTerminating/-1989351109=([java.util.concurrent.ThreadPoolExecutor], boolean), url/898879186=([org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport], org.apache.dubbo.common.URL), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), getIp/-49850945=([org.apache.dubbo.common.URL], java.lang.String), getPort/20614931=([org.apache.dubbo.common.URL], int), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var3966_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), toString/1090915316=([java.lang.Boolean], java.lang.String), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var1951_parseBoolean/746105335=([java.lang.String], boolean), dispatchThreadPoolExhaustedEvent/-1068144455=([org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport, java.lang.String], void), var1927-init=([], java.util.concurrent.RejectedExecutionException), <init>/-886329222=([java.util.concurrent.RejectedExecutionException, java.lang.String], void)}
; {var440=org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport, var2113=r1, var2898=java.lang.Runnable, var2000=r27, var2005=java.util.concurrent.ThreadPoolExecutor, var1191=r3, var2242=java.lang.Object, var799=$r0, var885=$r2, var3706=$i0, var1778=$r4, var1998=$i1, var341=$r5, var145=$i2, var1850=$r6, var2888=$i3, var3599=$r7, var1440=$i4, var3561=$r8, var2086=$l5, var3947=$r9, var1589=$l6, var733=$r10, var2962=$z0, var1951=java.lang.Boolean, var2337=$r11, var3787=$z1, var3316=$r12, var3122=$z2, var1509=$r13, var3440=org.apache.dubbo.common.URL, var321=$r14, var1960=$r15, var1742=$r16, var2115=$r17, var1391=$r18, var3888=$i7, var1187=$r19, var164=r20, var3966=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3570=$r21, var1483="0-1", var1329="too much client requesting provider", var3831="", var1271=$r23, var2592=$r22, var1481=$r24, var1320=$r25, var2588=$z3, var1927=java.util.concurrent.RejectedExecutionException, var162=$r26}
; {org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport=var440, r1=var2113, java.lang.Runnable=var2898, r27=var2000, java.util.concurrent.ThreadPoolExecutor=var2005, r3=var1191, java.lang.Object=var2242, $r0=var799, $r2=var885, $i0=var3706, $r4=var1778, $i1=var1998, $r5=var341, $i2=var145, $r6=var1850, $i3=var2888, $r7=var3599, $i4=var1440, $r8=var3561, $l5=var2086, $r9=var3947, $l6=var1589, $r10=var733, $z0=var2962, java.lang.Boolean=var1951, $r11=var2337, $z1=var3787, $r12=var3316, $z2=var3122, $r13=var1509, org.apache.dubbo.common.URL=var3440, $r14=var321, $r15=var1960, $r16=var1742, $r17=var2115, $r18=var1391, $i7=var3888, $r19=var1187, r20=var164, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3966, $r21=var3570, "0-1"=var1483, "too much client requesting provider"=var1329, ""=var3831, $r23=var1271, $r22=var2592, $r24=var1481, $r25=var1320, $z3=var2588, java.util.concurrent.RejectedExecutionException=var1927, $r26=var162}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>;	<java.lang.Boolean: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @this: org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport;	r27 := @parameter0: java.lang.Runnable;	r3 := @parameter1: java.util.concurrent.ThreadPoolExecutor;	$r0 = newarray (java.lang.Object)[14];	$r2 = r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: java.lang.String threadName>;	$r0[0] = $r2;	$i0 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: int getPoolSize()>();	$r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i0);	$r0[1] = $r4;	$i1 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: int getActiveCount()>();	$r5 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i1);	$r0[2] = $r5;	$i2 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: int getCorePoolSize()>();	$r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i2);	$r0[3] = $r6;	$i3 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: int getMaximumPoolSize()>();	$r7 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i3);	$r0[4] = $r7;	$i4 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: int getLargestPoolSize()>();	$r8 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i4);	$r0[5] = $r8;	$l5 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: long getTaskCount()>();	$r9 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l5);	$r0[6] = $r9;	$l6 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: long getCompletedTaskCount()>();	$r10 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l6);	$r0[7] = $r10;	$z0 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: boolean isShutdown()>();	$r11 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>($z0);	$r0[8] = $r11;	$z1 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: boolean isTerminated()>();	$r12 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>($z1);	$r0[9] = $r12;	$z2 = virtualinvoke r3.<java.util.concurrent.ThreadPoolExecutor: boolean isTerminating()>();	$r13 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>($z2);	$r0[10] = $r13;	$r14 = r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.URL url>;	$r15 = virtualinvoke $r14.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r0[11] = $r15;	$r16 = r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.URL url>;	$r17 = virtualinvoke $r16.<org.apache.dubbo.common.URL: java.lang.String getIp()>();	$r0[12] = $r17;	$r18 = r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.URL url>;	$i7 = virtualinvoke $r18.<org.apache.dubbo.common.URL: int getPort()>();	$r19 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i7);	$r0[13] = $r19;	r20 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Thread pool is EXHAUSTED! Thread Name: %s, Pool Size: %d (active: %d, core: %d, max: %d, largest: %d), Task: %d (completed: %d), Executor status:(isShutdown:%s, isTerminated:%s, isTerminating:%s), in %s://%s:%d!", $r0);	$r21 = <org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("0-1", "too much client requesting provider", "", r20);	$r23 = r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.URL url>;	$r22 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r24 = virtualinvoke $r22.<java.lang.Boolean: java.lang.String toString()>();	$r25 = virtualinvoke $r23.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("dump.enable", $r24);	$z3 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>($r25);	if $z3 == 0 goto virtualinvoke r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: void dispatchThreadPoolExhaustedEvent(java.lang.String)>(r20);	virtualinvoke r1.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: void dispatchThreadPoolExhaustedEvent(java.lang.String)>(r20);	$r26 = new java.util.concurrent.RejectedExecutionException;	specialinvoke $r26.<java.util.concurrent.RejectedExecutionException: void <init>(java.lang.String)>(r20);	throw $r26
;block_num 2