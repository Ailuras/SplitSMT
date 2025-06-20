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

(declare-sort var3888 0)
(declare-sort var3517 0)
(declare-sort var1323 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1098700499 (var1323 String) void)
(declare-fun cast-from-var3888-to-var1323 (var3888) var1323)
(declare-const null-var3888 var3888)
(declare-const null-String String)
(declare-const var1808 var3888) ; Statement: r0 := @this: org.apache.dubbo.qos.command.exception.PermissionDenyException 
(assert (not (= var1808 null-var3888)))
(declare-const var1403 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1403 null-String)))
(define-const var3742 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3742)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3742!1 String)
(assert (= var3742!1 ""))
(assert true)
(define-const var2591 String (append/672562846 var3742!1 "Permission Deny On Operation: ")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Permission Deny On Operation: ") 
(declare-const var3742!2 String)
(assert (= var3742!2 (str.++ var3742!1 "Permission Deny On Operation: ")))
(assert true)
(define-const var1242 String (append/672562846 var2591 var1403)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2591!1 String)
(assert (= var2591!1 (str.++ var2591 var1403)))
(assert true)
(define-const var2021 String (toString/-2075883882 var1242)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1098700499 (cast-from-var3888-to-var1323 var1808) var2021)) ; Statement: specialinvoke r0.<org.apache.dubbo.qos.command.exception.CommandException: void <init>(java.lang.String)>($r5) 

(declare-const var1808!1 var3888)
(declare-const var2021!1 String)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1098700499=([org.apache.dubbo.qos.command.exception.CommandException, java.lang.String], void), cast-from-var3888-to-var1323=([org.apache.dubbo.qos.command.exception.PermissionDenyException], org.apache.dubbo.qos.command.exception.CommandException)}
; {var3888=org.apache.dubbo.qos.command.exception.PermissionDenyException, var1808=r0, var1403=r2, var3517=null_type, var3742=$r1, var2591=$r3, var1242=$r4, var2021=$r5, var1323=org.apache.dubbo.qos.command.exception.CommandException}
; {org.apache.dubbo.qos.command.exception.PermissionDenyException=var3888, r0=var1808, r2=var1403, null_type=var3517, $r1=var3742, $r3=var2591, $r4=var1242, $r5=var2021, org.apache.dubbo.qos.command.exception.CommandException=var1323}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.qos.command.exception.PermissionDenyException;	r2 := @parameter0: java.lang.String;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Permission Deny On Operation: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke r0.<org.apache.dubbo.qos.command.exception.CommandException: void <init>(java.lang.String)>($r5);	return
;block_num 1