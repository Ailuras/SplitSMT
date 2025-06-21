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

(declare-sort var3441 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getColumnCount/586324415 (var3441) Int)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-fun getRowCount/-786081427 (var3441) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3441 var3441)
(declare-const var3751 var3441) ; Statement: r1 := @this: org.apache.dubbo.qos.textui.TTable 
(assert (not (= var3751 null-var3441)))
(define-const var1523 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1523)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1523!1 String)
(assert (= var1523!1 ""))
(assert true)
(define-const var1928 Int (getColumnCount/586324415 var3751)) ; Statement: $i0 = virtualinvoke r1.<org.apache.dubbo.qos.textui.TTable: int getColumnCount()>() 
(define-const var1805 (Array Int Int) arr-Int-init) ; Statement: r2 = newarray (int)[$i0] 
(define-const var1150 Int 0) ; Statement: i5 = 0 
(assert true) ; Non Conditional
(define-const var2860 Int (getLength-Arr-Int-1 var1805)) ; Statement: $i1 = lengthof r2 
 ; Statement: if i5 >= $i1 goto i6 = specialinvoke r1.<org.apache.dubbo.qos.textui.TTable: int getRowCount()>() 
(assert (>= var1150 var2860)) ; Cond: i5 >= $i1 
(assert true)
(define-const var1388 Int (getRowCount/-786081427 var3751)) ; Statement: i6 = specialinvoke r1.<org.apache.dubbo.qos.textui.TTable: int getRowCount()>() 
(define-const var2888 Int 0) ; Statement: i7 = 0 
(assert true) ; Non Conditional
 ; Statement: if i7 >= i6 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var2888 var1388)) ; Cond: i7 >= i6 
(assert true)
(define-const var486 String (toString/-2075883882 var1523!1)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getColumnCount/586324415=([org.apache.dubbo.qos.textui.TTable], int), arr-Int-init=([], int[]), getLength-Arr-Int-1=([int[]], int), getRowCount/-786081427=([org.apache.dubbo.qos.textui.TTable], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3441=org.apache.dubbo.qos.textui.TTable, var3751=r1, var1523=$r0, var1928=$i0, var1805=r2, var1150=i5, var2860=$i1, var1388=i6, var2888=i7, var486=$r3}
; {org.apache.dubbo.qos.textui.TTable=var3441, r1=var3751, $r0=var1523, $i0=var1928, r2=var1805, i5=var1150, $i1=var2860, i6=var1388, i7=var2888, $r3=var486}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.qos.textui.TTable;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$i0 = virtualinvoke r1.<org.apache.dubbo.qos.textui.TTable: int getColumnCount()>();	r2 = newarray (int)[$i0];	i5 = 0;	$i1 = lengthof r2;	if i5 >= $i1 goto i6 = specialinvoke r1.<org.apache.dubbo.qos.textui.TTable: int getRowCount()>();	i6 = specialinvoke r1.<org.apache.dubbo.qos.textui.TTable: int getRowCount()>();	i7 = 0;	if i7 >= i6 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 5