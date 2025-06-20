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

(declare-sort var3804 0)
(declare-sort var867 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getUsername/657618160 (var3804) String)
(declare-fun var867_isEmpty/-813097145 (String) Bool)
(declare-fun getPassword/-1989005045 (var3804) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3804 var3804)
(declare-const var460 var3804) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var460 null-var3804)))
(define-const var2755 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2755)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2755!1 String)
(assert (= var2755!1 ""))
(assert true)
(define-const var853 String (getUsername/657618160 var460)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUsername()>() 
(define-const var1027 Bool (var867_isEmpty/-813097145 var853)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r2) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUsername()>() 
(assert (not (= (ite var1027 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3908 String (getPassword/-1989005045 var460)) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPassword()>() 
(define-const var2581 Bool (var867_isEmpty/-813097145 var3908)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7) 
 ; Statement: if $z3 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUsername()>() 
(assert (not (= (ite var2581 1 0) 0))) ; Negate: Cond: $z3 == 0  
(assert true)
(define-const var2162 String (toString/-2075883882 var2755!1)) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getUsername/657618160=([org.apache.dubbo.common.URL], java.lang.String), var867_isEmpty/-813097145=([java.lang.String], boolean), getPassword/-1989005045=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3804=org.apache.dubbo.common.URL, var460=r1, var2755=$r0, var853=$r2, var867=org.apache.dubbo.common.utils.StringUtils, var1027=$z0, var3908=$r7, var2581=$z3, var2162=$r8}
; {org.apache.dubbo.common.URL=var3804, r1=var460, $r0=var2755, $r2=var853, org.apache.dubbo.common.utils.StringUtils=var867, $z0=var1027, $r7=var3908, $z3=var2581, $r8=var2162}
;seq <java.lang.StringBuilder: void <init>()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUsername()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r2);	if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUsername()>();	$r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPassword()>();	$z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7);	if $z3 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUsername()>();	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 3