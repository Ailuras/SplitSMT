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

(declare-sort var1013 0)
(declare-sort var2018 0)
(declare-sort var1205 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getClass/1258963082 (var2018) ClassObject)
(declare-const null-var1013 var1013)
(declare-const null-var2018 var2018)
(declare-const null-String String)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-__Array__Int__var2018__ (Array Int var2018))
(declare-const var1717 var1013) ; Statement: r24 := @this: org.apache.dubbo.common.bytecode.Wrapper$1 
(assert (not (= var1717 null-var1013)))
(declare-const var3141 var2018) ; Statement: r18 := @parameter0: java.lang.Object 
(assert (not (= var3141 null-var2018)))
(declare-const var3132 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3132 null-String)))
(declare-const var3921 (Array Int ClassObject)) ; Statement: r25 := @parameter2: java.lang.Class[] 
(assert (not (= var3921 null-__Array__Int__ClassObject__)))
(declare-const var1829 (Array Int var2018)) ; Statement: r11 := @parameter3: java.lang.Object[] 
(assert (not (= var1829 null-__Array__Int__var2018__)))
(define-const var2931 String "getClass") ; Statement: $r1 = "getClass" 
(assert true)
(define-const var3041 Bool (= var2931 var3132)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "hashCode" 
(assert (not (= (ite var3041 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3086 ClassObject (getClass/1258963082 var3141)) ; Statement: $r23 = virtualinvoke r18.<java.lang.Object: java.lang.Class getClass()>() 
 ; Statement: return $r23 
(check-sat)
; {getClass/1258963082=([java.lang.Object], java.lang.Class)}
; {var1013=org.apache.dubbo.common.bytecode.Wrapper$1, var1717=r24, var2018=java.lang.Object, var3141=r18, var3132=r0, var1205=null_type, var3921=r25, var1829=r11, var2931=$r1, var3041=$z0, var3086=$r23}
; {org.apache.dubbo.common.bytecode.Wrapper$1=var1013, r24=var1717, java.lang.Object=var2018, r18=var3141, r0=var3132, null_type=var1205, r25=var3921, r11=var1829, $r1=var2931, $z0=var3041, $r23=var3086}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r24 := @this: org.apache.dubbo.common.bytecode.Wrapper$1;	r18 := @parameter0: java.lang.Object;	r0 := @parameter1: java.lang.String;	r25 := @parameter2: java.lang.Class[];	r11 := @parameter3: java.lang.Object[];	$r1 = "getClass";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = "hashCode";	$r23 = virtualinvoke r18.<java.lang.Object: java.lang.Class getClass()>();	return $r23
;block_num 2