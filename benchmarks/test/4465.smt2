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

(declare-sort var3389 0)
(declare-sort var617 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun toCharArray/415275702 (String) (Array Int Int))
(declare-fun var617_bytes2base64/-1924451696 ((Array Int Int) Int Int (Array Int Int)) String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const var3822 (Array Int Int)) ; Statement: r1 := @parameter0: byte[] 
(assert (not (= var3822 null-__Array__Int__Int__)))
(declare-const var1289 Int) ; Statement: i1 := @parameter1: int 
(assert (not (= var1289 null-Int)))
(declare-const var3949 Int) ; Statement: i2 := @parameter2: int 
(assert (not (= var3949 null-Int)))
(declare-const var357 String) ; Statement: r0 := @parameter3: java.lang.String 
(assert (not (= var357 null-String)))
(assert true)
(define-const var1602 Int (length/-134980193 var357)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if $i0 >= 64 goto $r2 = virtualinvoke r0.<java.lang.String: char[] toCharArray()>() 
(assert (>= var1602 64)) ; Cond: $i0 >= 64 
(assert true)
(define-const var3565 (Array Int Int) (toCharArray/415275702 var357)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: char[] toCharArray()>() 
(define-const var1132 String (var617_bytes2base64/-1924451696 var3822 var1289 var3949 var3565)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.io.Bytes: java.lang.String bytes2base64(byte[],int,int,char[])>(r1, i1, i2, $r2) 
 ; Statement: return $r3 
(check-sat)
; {length/-134980193=([java.lang.String], int), toCharArray/415275702=([java.lang.String], char[]), var617_bytes2base64/-1924451696=([byte[], int, int, char[]], java.lang.String)}
; {var3822=r1, var1289=i1, var3949=i2, var357=r0, var3389=null_type, var1602=$i0, var3565=$r2, var617=org.apache.dubbo.common.io.Bytes, var1132=$r3}
; {r1=var3822, i1=var1289, i2=var3949, r0=var357, null_type=var3389, $i0=var1602, $r2=var3565, org.apache.dubbo.common.io.Bytes=var617, $r3=var1132}
;seq <java.lang.String: int length()>;	<java.lang.String: char[] toCharArray()>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: char[] toCharArray()>": 1}
;stmts r1 := @parameter0: byte[];	i1 := @parameter1: int;	i2 := @parameter2: int;	r0 := @parameter3: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if $i0 >= 64 goto $r2 = virtualinvoke r0.<java.lang.String: char[] toCharArray()>();	$r2 = virtualinvoke r0.<java.lang.String: char[] toCharArray()>();	$r3 = staticinvoke <org.apache.dubbo.common.io.Bytes: java.lang.String bytes2base64(byte[],int,int,char[])>(r1, i1, i2, $r2);	return $r3
;block_num 2