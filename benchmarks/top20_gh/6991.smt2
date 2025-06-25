(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1009 0)
(declare-sort var3443 0)
(declare-sort var955 0)
(declare-sort var3539 0)
(declare-sort var1150 0)
(declare-sort var392 0)
(declare-sort var577 0)
(declare-sort var1766 0)
(declare-sort var2852 0)
(declare-sort var1673 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var955_isAttrStorageEmpty/-1529149563 (var955) Bool)
(declare-fun var955_getAttributesString/-1728137881 (var955) String)
(declare-fun var3539_of/184955601 ((Array Int var1150)) var3539)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1150__ ((Array Int String)) (Array Int var1150))
(declare-fun var577_bootstrap$/-393957991 () var392)
(declare-fun var3539_filter/320182972 (var3539 var392) var3539)
(declare-fun var2852_toList/714215649 () var1766)
(declare-fun var3539_collect/-2050842585 (var3539 var1766) var1150)
(declare-fun cast-from-var1150-to-var1673 (var1150) var1673)
(declare-fun var1673_iterator/-912451715 (var1673) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-const null-var1009 var1009)
(declare-const null-String String)
(declare-const null-var955 var955)
(declare-const var219 var1009) ; Statement: r9 := @parameter0: jadx.api.ICodeWriter 
(assert (not (= var219 null-var1009)))
(declare-const var728 String) ; Statement: r10 := @parameter1: java.lang.String 
(assert (not (= var728 null-String)))
(declare-const var2130 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var2130 null-String)))
(declare-const var173 var955) ; Statement: r0 := @parameter3: jadx.core.dex.attributes.IAttributeNode 
(assert (not (= var173 null-var955)))
(define-const var3639 Bool (var955_isAttrStorageEmpty/-1529149563 var173)) ; Statement: $z0 = interfaceinvoke r0.<jadx.core.dex.attributes.IAttributeNode: boolean isAttrStorageEmpty()>() 
 ; Statement: if $z0 == 0 goto $r2 = interfaceinvoke r0.<jadx.core.dex.attributes.IAttributeNode: java.lang.String getAttributesString()>() 
(assert (= (ite var3639 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3819 String (var955_getAttributesString/-1728137881 var173)) ; Statement: $r2 = interfaceinvoke r0.<jadx.core.dex.attributes.IAttributeNode: java.lang.String getAttributesString()>() 
(define-const var3073 String (str.++ "\u0001 \u0001" var2130 var3819)) ; Statement: $r20 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String,java.lang.String)>(r1, $r2) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001 \u0001") 
(assert true) ; Non Conditional
; split operation: var1580 = var3073.split("\u005cR") ; Statement: $r3 = virtualinvoke $r20.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\R") 
(define-const var3711 var3539 (var3539_of/184955601 (cast-from-__Array__Int__String__-to-__Array__Int__var1150__ var1580))) ; Statement: $r5 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r3) 
(define-const var3408 var392 var577_bootstrap$/-393957991) ; Statement: $r4 = staticinvoke <jadx.core.utils.DebugUtils$notBlank__492: java.util.function.Predicate bootstrap$()>() 
(define-const var1480 var3539 (var3539_filter/320182972 var3711 var3408)) ; Statement: $r7 = interfaceinvoke $r5.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r4) 
(define-const var3432 var1766 var2852_toList/714215649) ; Statement: $r6 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>() 
(define-const var3716 var1150 (var3539_collect/-2050842585 var1480 var3432)) ; Statement: $r8 = interfaceinvoke $r7.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r6) 
(define-const var1527 var1673 (cast-from-var1150-to-var1673 var3716)) ; Statement: $r18 = (java.util.List) $r8 
(define-const var2441 Iterator (var1673_iterator/-912451715 var1527)) ; Statement: $r19 = interfaceinvoke $r18.<java.util.List: java.util.Iterator iterator()>() 
(define-const var992 Bool (Iterator_hasNext/-1669924200 var2441)) ; Statement: $z1 = interfaceinvoke $r19.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z1 != 0 goto $r13 = interfaceinvoke r9.<jadx.api.ICodeWriter: jadx.api.ICodeWriter startLine(java.lang.String)>(r10) 
(assert (not (not (= (ite var992 1 0) 0)))) ; Negate: Cond: $z1 != 0  
 ; Statement: return 
(check-sat)
; {var955_isAttrStorageEmpty/-1529149563=([jadx.core.dex.attributes.IAttributeNode], boolean), var955_getAttributesString/-1728137881=([jadx.core.dex.attributes.IAttributeNode], java.lang.String), var3539_of/184955601=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var1150__=([java.lang.String[]], java.lang.Object[]), var577_bootstrap$/-393957991=([], java.util.function.Predicate), var3539_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var2852_toList/714215649=([], java.util.stream.Collector), var3539_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var1150-to-var1673=([java.lang.Object], java.util.List), var1673_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean)}
; {var1009=jadx.api.ICodeWriter, var219=r9, var728=r10, var3443=null_type, var2130=r1, var955=jadx.core.dex.attributes.IAttributeNode, var173=r0, var3639=$z0, var3819=$r2, var3073=$r20, var1580=$r3, var3539=java.util.stream.Stream, var1150=java.lang.Object, var3711=$r5, var392=java.util.function.Predicate, var577=jadx.core.utils.DebugUtils$notBlank__492, var3408=$r4, var1480=$r7, var1766=java.util.stream.Collector, var2852=java.util.stream.Collectors, var3432=$r6, var3716=$r8, var1673=java.util.List, var1527=$r18, var2441=$r19, var992=$z1}
; {jadx.api.ICodeWriter=var1009, r9=var219, r10=var728, null_type=var3443, r1=var2130, jadx.core.dex.attributes.IAttributeNode=var955, r0=var173, $z0=var3639, $r2=var3819, $r20=var3073, $r3=var1580, java.util.stream.Stream=var3539, java.lang.Object=var1150, $r5=var3711, java.util.function.Predicate=var392, jadx.core.utils.DebugUtils$notBlank__492=var577, $r4=var3408, $r7=var1480, java.util.stream.Collector=var1766, java.util.stream.Collectors=var2852, $r6=var3432, $r8=var3716, java.util.List=var1673, $r18=var1527, $r19=var2441, $z1=var992}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r9 := @parameter0: jadx.api.ICodeWriter;	r10 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	r0 := @parameter3: jadx.core.dex.attributes.IAttributeNode;	$z0 = interfaceinvoke r0.<jadx.core.dex.attributes.IAttributeNode: boolean isAttrStorageEmpty()>();	if $z0 == 0 goto $r2 = interfaceinvoke r0.<jadx.core.dex.attributes.IAttributeNode: java.lang.String getAttributesString()>();	$r2 = interfaceinvoke r0.<jadx.core.dex.attributes.IAttributeNode: java.lang.String getAttributesString()>();	$r20 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String,java.lang.String)>(r1, $r2) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001 \u0001");	$r3 = virtualinvoke $r20.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\R");	$r5 = staticinvoke <java.util.stream.Stream: java.util.stream.Stream of(java.lang.Object[])>($r3);	$r4 = staticinvoke <jadx.core.utils.DebugUtils$notBlank__492: java.util.function.Predicate bootstrap$()>();	$r7 = interfaceinvoke $r5.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r4);	$r6 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>();	$r8 = interfaceinvoke $r7.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r6);	$r18 = (java.util.List) $r8;	$r19 = interfaceinvoke $r18.<java.util.List: java.util.Iterator iterator()>();	$z1 = interfaceinvoke $r19.<java.util.Iterator: boolean hasNext()>();	if $z1 != 0 goto $r13 = interfaceinvoke r9.<jadx.api.ICodeWriter: jadx.api.ICodeWriter startLine(java.lang.String)>(r10);	return
;block_num 4