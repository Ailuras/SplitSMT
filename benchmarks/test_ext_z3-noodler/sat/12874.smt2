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

(declare-sort var210 0)
(declare-sort var3361 0)
(declare-sort var2097 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getColumnCount/586324415 (var210) Int)
(declare-fun arr-var3361-init () (Array Int var3361))
(declare-fun getLength-Arr-var3361-1 ((Array Int var3361)) Int)
(declare-const null-var210 var210)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const null-Int Int)
(declare-const null-var2097 var2097)
(declare-const var1389 var210) ; Statement: r1 := @this: org.apache.dubbo.qos.textui.TTable 
(assert (not (= var1389 null-var210)))
(declare-const var682 (Array Int Int)) ; Statement: r4 := @parameter0: int[] 
(assert (not (= var682 null-__Array__Int__Int__)))
(declare-const var1244 Int) ; Statement: i4 := @parameter1: int 
(assert (not (= var1244 null-Int)))
(define-const var1424 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1424)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1424!1 String)
(assert (= var1424!1 ""))
(assert true)
(define-const var2599 Int (getColumnCount/586324415 var1389)) ; Statement: $i0 = virtualinvoke r1.<org.apache.dubbo.qos.textui.TTable: int getColumnCount()>() 
(define-const var1474 (Array Int var3361) arr-var3361-init) ; Statement: r2 = newarray (java.util.Scanner)[$i0] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3769 var2097) ; Statement: $r31 := @caughtexception 
(assert (not (= var3769 null-var2097)))
(assert true) ; Non Conditional
(define-const var2790 Int (getLength-Arr-var3361-1 var1474)) ; Statement: i5 = lengthof r2 
(define-const var1130 Int 0) ; Statement: i11 = 0 
(assert true) ; Non Conditional
 ; Statement: if i11 >= i5 goto throw $r31 
(assert (>= var1130 var2790)) ; Cond: i11 >= i5 
 ; Statement: throw $r31 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getColumnCount/586324415=([org.apache.dubbo.qos.textui.TTable], int), arr-var3361-init=([], java.util.Scanner[]), getLength-Arr-var3361-1=([java.util.Scanner[]], int)}
; {var210=org.apache.dubbo.qos.textui.TTable, var1389=r1, var682=r4, var1244=i4, var1424=$r0, var2599=$i0, var3361=java.util.Scanner, var1474=r2, var2097=java.lang.Throwable, var3769=$r31, var2790=i5, var1130=i11}
; {org.apache.dubbo.qos.textui.TTable=var210, r1=var1389, r4=var682, i4=var1244, $r0=var1424, $i0=var2599, java.util.Scanner=var3361, r2=var1474, java.lang.Throwable=var2097, $r31=var3769, i5=var2790, i11=var1130}
;seq <java.lang.StringBuilder: void <init>()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1}
;stmts r1 := @this: org.apache.dubbo.qos.textui.TTable;	r4 := @parameter0: int[];	i4 := @parameter1: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$i0 = virtualinvoke r1.<org.apache.dubbo.qos.textui.TTable: int getColumnCount()>();	r2 = newarray (java.util.Scanner)[$i0];	$r31 := @caughtexception;	i5 = lengthof r2;	i11 = 0;	if i11 >= i5 goto throw $r31;	throw $r31
;block_num 5