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

(declare-sort var1989 0)
(declare-sort var1107 0)
(declare-sort var1572 0)
(declare-sort var2501 0)
(declare-sort var977 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1572_toString/-109309168 (var1107) String)
(declare-fun <init>/-1084991535 (var2501 String) void)
(declare-fun cast-from-var1989-to-var2501 (var1989) var2501)
(declare-fun getClass/1258963082 (var977) ClassObject)
(declare-fun cast-from-var1107-to-var977 (var1107) var977)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun exceptionClass/-1350522272 (var1989) String)
(declare-fun getMessage/849299655 (var1107) String)
(declare-fun exceptionMessage/-1350522272 (var1989) String)
(declare-const null-var1989 var1989)
(declare-const null-var1107 var1107)
(declare-const var2822 var1989) ; Statement: r0 := @this: org.apache.dubbo.rpc.service.GenericException 
(assert (not (= var2822 null-var1989)))
(declare-const var1818 var1107) ; Statement: r1 := @parameter0: java.lang.Throwable 
(assert (not (= var1818 null-var1107)))
(define-const var3136 String (var1572_toString/-109309168 var1818)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>(r1) 
(assert true)
;(assert (<init>/-1084991535 (cast-from-var1989-to-var2501 var2822) var3136)) ; Statement: specialinvoke r0.<java.lang.RuntimeException: void <init>(java.lang.String)>($r2) 

(declare-const var2822!1 var1989)
(declare-const var3136!1 String)
(assert true)
(define-const var338 ClassObject (getClass/1258963082 (cast-from-var1107-to-var977 var1818))) ; Statement: $r3 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1094 String (getName/-1958580599 var338)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>() 
(declare-const var2822!2 var1989)
(assert (not (= var2822!2 null-var1989)))
(assert (= (exceptionClass/-1350522272 var2822!2) var1094)) ; Statement: r0.<org.apache.dubbo.rpc.service.GenericException: java.lang.String exceptionClass> = $r4 
(assert true)
(define-const var855 String (getMessage/849299655 var1818)) ; Statement: $r5 = virtualinvoke r1.<java.lang.Throwable: java.lang.String getMessage()>() 
(declare-const var2822!3 var1989)
(assert (not (= var2822!3 null-var1989)))
(assert (= (exceptionMessage/-1350522272 var2822!3) var855)) ; Statement: r0.<org.apache.dubbo.rpc.service.GenericException: java.lang.String exceptionMessage> = $r5 
 ; Statement: return 
(check-sat)
; {var1572_toString/-109309168=([java.lang.Throwable], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void), cast-from-var1989-to-var2501=([org.apache.dubbo.rpc.service.GenericException], java.lang.RuntimeException), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var1107-to-var977=([java.lang.Throwable], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), exceptionClass/-1350522272=([org.apache.dubbo.rpc.service.GenericException], java.lang.String), getMessage/849299655=([java.lang.Throwable], java.lang.String), exceptionMessage/-1350522272=([org.apache.dubbo.rpc.service.GenericException], java.lang.String)}
; {var1989=org.apache.dubbo.rpc.service.GenericException, var2822=r0, var1107=java.lang.Throwable, var1818=r1, var1572=org.apache.dubbo.common.utils.StringUtils, var3136=$r2, var2501=java.lang.RuntimeException, var977=java.lang.Object, var338=$r3, var1094=$r4, var855=$r5}
; {org.apache.dubbo.rpc.service.GenericException=var1989, r0=var2822, java.lang.Throwable=var1107, r1=var1818, org.apache.dubbo.common.utils.StringUtils=var1572, $r2=var3136, java.lang.RuntimeException=var2501, java.lang.Object=var977, $r3=var338, $r4=var1094, $r5=var855}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.service.GenericException;	r1 := @parameter0: java.lang.Throwable;	$r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>(r1);	specialinvoke r0.<java.lang.RuntimeException: void <init>(java.lang.String)>($r2);	$r3 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>();	r0.<org.apache.dubbo.rpc.service.GenericException: java.lang.String exceptionClass> = $r4;	$r5 = virtualinvoke r1.<java.lang.Throwable: java.lang.String getMessage()>();	r0.<org.apache.dubbo.rpc.service.GenericException: java.lang.String exceptionMessage> = $r5;	return
;block_num 1