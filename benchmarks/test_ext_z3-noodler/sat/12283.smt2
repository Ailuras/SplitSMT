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

(declare-sort var1037 0)
(declare-sort var245 0)
(declare-sort var1935 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1098700499 (var1935 String) void)
(declare-fun cast-from-var1037-to-var1935 (var1037) var1935)
(declare-const null-var1037 var1037)
(declare-const null-String String)
(declare-const var2435 var1037) ; Statement: r0 := @this: org.apache.dubbo.qos.command.exception.NoSuchCommandException 
(assert (not (= var2435 null-var1037)))
(declare-const var621 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var621 null-String)))
(define-const var57 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var57)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var57!1 String)
(assert (= var57!1 ""))
(assert true)
(define-const var1950 String (append/672562846 var57!1 "NoSuchCommandException:")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("NoSuchCommandException:") 
(declare-const var57!2 String)
(assert (= var57!2 (str.++ var57!1 "NoSuchCommandException:")))
(assert true)
(define-const var2252 String (append/672562846 var1950 var621)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var1950!1 String)
(assert (= var1950!1 (str.++ var1950 var621)))
(assert true)
(define-const var2081 String (toString/-2075883882 var2252)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1098700499 (cast-from-var1037-to-var1935 var2435) var2081)) ; Statement: specialinvoke r0.<org.apache.dubbo.qos.command.exception.CommandException: void <init>(java.lang.String)>($r5) 

(declare-const var2435!1 var1037)
(declare-const var2081!1 String)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1098700499=([org.apache.dubbo.qos.command.exception.CommandException, java.lang.String], void), cast-from-var1037-to-var1935=([org.apache.dubbo.qos.command.exception.NoSuchCommandException], org.apache.dubbo.qos.command.exception.CommandException)}
; {var1037=org.apache.dubbo.qos.command.exception.NoSuchCommandException, var2435=r0, var621=r2, var245=null_type, var57=$r1, var1950=$r3, var2252=$r4, var2081=$r5, var1935=org.apache.dubbo.qos.command.exception.CommandException}
; {org.apache.dubbo.qos.command.exception.NoSuchCommandException=var1037, r0=var2435, r2=var621, null_type=var245, $r1=var57, $r3=var1950, $r4=var2252, $r5=var2081, org.apache.dubbo.qos.command.exception.CommandException=var1935}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.qos.command.exception.NoSuchCommandException;	r2 := @parameter0: java.lang.String;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("NoSuchCommandException:");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke r0.<org.apache.dubbo.qos.command.exception.CommandException: void <init>(java.lang.String)>($r5);	return
;block_num 1