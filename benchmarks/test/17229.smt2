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

(declare-sort var876 0)
(declare-sort var1434 0)
(declare-sort var1014 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1434_iterator/-1617794947 (var1434) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var1014-init () var1014)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1557872005 (var1014 String) void)
(declare-const null-String String)
(declare-const null-var1434 var1434)
(declare-const var3727 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var3727 null-String)))
(declare-const var407 var1434) ; Statement: r0 := @parameter1: java.util.Collection 
(assert (not (= var407 null-var1434)))
(define-const var862 Iterator (var1434_iterator/-1617794947 var407)) ; Statement: r1 = interfaceinvoke r0.<java.util.Collection: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1733 Bool (Iterator_hasNext/-1669924200 var862)) ; Statement: $z0 = interfaceinvoke r1.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r2 = new java.io.IOException 
(assert (= (ite var1733 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1466 var1014 var1014-init) ; Statement: $r2 = new java.io.IOException 
(define-const var1747 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1747)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1747!1 String)
(assert (= var1747!1 ""))
(assert true)
(define-const var1414 String (append/672562846 var1747!1 "Unexpected serialization type:")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected serialization type:") 
(declare-const var1747!2 String)
(assert (= var1747!2 (str.++ var1747!1 "Unexpected serialization type:")))
(assert true)
(define-const var140 String (append/672562846 var1414 var3727)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var1414!1 String)
(assert (= var1414!1 (str.++ var1414 var3727)))
(assert true)
(define-const var3681 String (append/672562846 var140 " received from network, please check if the peer send the right id.")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" received from network, please check if the peer send the right id.") 
(declare-const var140!1 String)
(assert (= var140!1 (str.++ var140 " received from network, please check if the peer send the right id.")))
(assert true)
(define-const var2810 String (toString/-2075883882 var3681)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1557872005 var1466 var2810)) ; Statement: specialinvoke $r2.<java.io.IOException: void <init>(java.lang.String)>($r8) 

(declare-const var1466!1 var1014)
(declare-const var2810!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var1434_iterator/-1617794947=([java.util.Collection], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var1014-init=([], java.io.IOException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1557872005=([java.io.IOException, java.lang.String], void)}
; {var3727=r4, var876=null_type, var1434=java.util.Collection, var407=r0, var862=r1, var1733=$z0, var1014=java.io.IOException, var1466=$r2, var1747=$r3, var1414=$r5, var140=$r6, var3681=$r7, var2810=$r8}
; {r4=var3727, null_type=var876, java.util.Collection=var1434, r0=var407, r1=var862, $z0=var1733, java.io.IOException=var1014, $r2=var1466, $r3=var1747, $r5=var1414, $r6=var140, $r7=var3681, $r8=var2810}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r4 := @parameter0: java.lang.String;	r0 := @parameter1: java.util.Collection;	r1 = interfaceinvoke r0.<java.util.Collection: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r1.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r2 = new java.io.IOException;	$r2 = new java.io.IOException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected serialization type:");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" received from network, please check if the peer send the right id.");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.io.IOException: void <init>(java.lang.String)>($r8);	throw $r2
;block_num 3