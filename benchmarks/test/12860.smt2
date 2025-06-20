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

(declare-sort var1386 0)
(declare-sort var1057 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1057_size/-959786421 (var1057) Int)
(declare-const null-var1386 var1386)
(declare-const null-String String)
(declare-const null-var1057 var1057)
(declare-const var202 var1386) ; Statement: r11 := @this: org.apache.dubbo.qos.command.impl.InvokeTelnet 
(assert (not (= var202 null-var1386)))
(declare-const var2060 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var2060 null-String)))
(declare-const var1853 var1057) ; Statement: r1 := @parameter1: java.util.List 
(assert (not (= var1853 null-var1057)))
(assert true)
;(assert (append/672562846 var2060 "Methods:\r\n")) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Methods:\r\n") 
(declare-const var2060!1 String)
(assert (= var2060!1 (str.++ var2060 "Methods:\r\n")))
(define-const var185 Int 0) ; Statement: i5 = 0 
(assert true) ; Non Conditional
(define-const var3726 Int (var1057_size/-959786421 var1853)) ; Statement: $i0 = interfaceinvoke r1.<java.util.List: int size()>() 
 ; Statement: if i5 >= $i0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Please use the select command to select the method you want to invoke. eg: select 1") 
(assert (>= var185 var3726)) ; Cond: i5 >= $i0 
(assert true)
;(assert (append/672562846 var2060!1 "Please use the select command to select the method you want to invoke. eg: select 1")) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Please use the select command to select the method you want to invoke. eg: select 1") 
(declare-const var2060!2 String)
(assert (= var2060!2 (str.++ var2060!1 "Please use the select command to select the method you want to invoke. eg: select 1")))
 ; Statement: return 
(check-sat)
; {append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1057_size/-959786421=([java.util.List], int)}
; {var1386=org.apache.dubbo.qos.command.impl.InvokeTelnet, var202=r11, var2060=r0, var1057=java.util.List, var1853=r1, var185=i5, var3726=$i0}
; {org.apache.dubbo.qos.command.impl.InvokeTelnet=var1386, r11=var202, r0=var2060, java.util.List=var1057, r1=var1853, i5=var185, $i0=var3726}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r11 := @this: org.apache.dubbo.qos.command.impl.InvokeTelnet;	r0 := @parameter0: java.lang.StringBuilder;	r1 := @parameter1: java.util.List;	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Methods:\r\n");	i5 = 0;	$i0 = interfaceinvoke r1.<java.util.List: int size()>();	if i5 >= $i0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Please use the select command to select the method you want to invoke. eg: select 1");	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Please use the select command to select the method you want to invoke. eg: select 1");	return
;block_num 3