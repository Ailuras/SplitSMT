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

(declare-sort var220 0)
(declare-sort var2061 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var2061_example/921136963 (var2061) (Array Int String))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var220 var220)
(declare-const null-var2061 var2061)
(declare-const var2687 var220) ; Statement: r6 := @this: org.apache.dubbo.qos.command.impl.Help 
(assert (not (= var2687 null-var220)))
(declare-const var490 var2061) ; Statement: r1 := @parameter0: org.apache.dubbo.qos.api.Cmd 
(assert (not (= var490 null-var2061)))
(define-const var1788 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1788)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1788!1 String)
(assert (= var1788!1 ""))
(define-const var3268 (Array Int String) (var2061_example/921136963 var490)) ; Statement: r2 = interfaceinvoke r1.<org.apache.dubbo.qos.api.Cmd: java.lang.String[] example()>() 
(define-const var1640 Int (getLength-Arr-String-1 var3268)) ; Statement: i0 = lengthof r2 
(define-const var2478 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var2478 var1640)) ; Cond: i1 >= i0 
(assert true)
(define-const var814 String (toString/-2075883882 var1788!1)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var2061_example/921136963=([org.apache.dubbo.qos.api.Cmd], java.lang.String[]), getLength-Arr-String-1=([java.lang.String[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var220=org.apache.dubbo.qos.command.impl.Help, var2687=r6, var2061=org.apache.dubbo.qos.api.Cmd, var490=r1, var1788=$r0, var3268=r2, var1640=i0, var2478=i1, var814=$r3}
; {org.apache.dubbo.qos.command.impl.Help=var220, r6=var2687, org.apache.dubbo.qos.api.Cmd=var2061, r1=var490, $r0=var1788, r2=var3268, i0=var1640, i1=var2478, $r3=var814}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r6 := @this: org.apache.dubbo.qos.command.impl.Help;	r1 := @parameter0: org.apache.dubbo.qos.api.Cmd;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	r2 = interfaceinvoke r1.<org.apache.dubbo.qos.api.Cmd: java.lang.String[] example()>();	i0 = lengthof r2;	i1 = 0;	if i1 >= i0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 3