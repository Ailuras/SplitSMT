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

(declare-sort var1038 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun String-init () String)
(declare-fun name/1362759805 (var1038) String)
(declare-fun <init>/1365996485 (String (Array Int Int) Int Int String) void)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const null-var1038 var1038)
(declare-const var3709 (Array Int Int)) ; Statement: r0 := @parameter0: byte[] 
(assert (not (= var3709 null-__Array__Int__Int__)))
(declare-const var2345 var1038) ; Statement: r3 := @parameter1: java.nio.charset.Charset 
(assert (not (= var2345 null-var1038)))
(define-const var1471 Int (getLength-Arr-Int-1 var3709)) ; Statement: $i0 = lengthof r0 
(define-const var3673 (Array Int Int) arr-Int-init) ; Statement: r1 = newarray (byte)[$i0] 
(define-const var1122 Int 0) ; Statement: i21 = 0 
(define-const var925 Int 0) ; Statement: i22 = 0 
(assert true) ; Non Conditional
(define-const var3110 Int (getLength-Arr-Int-1 var3709)) ; Statement: $i1 = lengthof r0 
 ; Statement: if i22 >= $i1 goto (branch) 
(assert (>= var925 var3110)) ; Cond: i22 >= $i1 
 ; Statement: if i21 != 0 goto $r6 = new java.lang.String 
(assert (not (= var1122 0))) ; Cond: i21 != 0 
(define-const var2375 String String-init) ; Statement: $r6 = new java.lang.String 
(assert true)
(define-const var200 String (name/1362759805 var2345)) ; Statement: $r4 = virtualinvoke r3.<java.nio.charset.Charset: java.lang.String name()>() 
(assert true)
;(assert (<init>/1365996485 var2375 var3673 0 var1122 var200)) ; Statement: specialinvoke $r6.<java.lang.String: void <init>(byte[],int,int,java.lang.String)>(r1, 0, i21, $r4) 

(declare-const var2375!1 String)
(declare-const var3673!1 (Array Int Int))
(declare-const var978 Int)
(declare-const var1122!1 Int)
(declare-const var200!1 String)
(assert true)
(define-const var178 String (trim/-847153721 var2375!1)) ; Statement: $r5 = virtualinvoke $r6.<java.lang.String: java.lang.String trim()>() 
 ; Statement: return $r5 
(check-sat)
; {getLength-Arr-Int-1=([byte[]], int), arr-Int-init=([], byte[]), String-init=([], java.lang.String), name/1362759805=([java.nio.charset.Charset], java.lang.String), <init>/1365996485=([java.lang.String, byte[], int, int, java.lang.String], void), trim/-847153721=([java.lang.String], java.lang.String)}
; {var3709=r0, var1038=java.nio.charset.Charset, var2345=r3, var1471=$i0, var3673=r1, var1122=i21, var925=i22, var3110=$i1, var2375=$r6, var200=$r4, var978=0, var178=$r5}
; {r0=var3709, java.nio.charset.Charset=var1038, r3=var2345, $i0=var1471, r1=var3673, i21=var1122, i22=var925, $i1=var3110, $r6=var2375, $r4=var200, 0=var978, $r5=var178}
;seq <java.lang.String: void <init>(byte[],int,int,java.lang.String)>;	<java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: void <init>(byte[],int,int,java.lang.String)>": 1,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r0 := @parameter0: byte[];	r3 := @parameter1: java.nio.charset.Charset;	$i0 = lengthof r0;	r1 = newarray (byte)[$i0];	i21 = 0;	i22 = 0;	$i1 = lengthof r0;	if i22 >= $i1 goto (branch);	if i21 != 0 goto $r6 = new java.lang.String;	$r6 = new java.lang.String;	$r4 = virtualinvoke r3.<java.nio.charset.Charset: java.lang.String name()>();	specialinvoke $r6.<java.lang.String: void <init>(byte[],int,int,java.lang.String)>(r1, 0, i21, $r4);	$r5 = virtualinvoke $r6.<java.lang.String: java.lang.String trim()>();	return $r5
;block_num 4