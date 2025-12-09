import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import 'package:taskly/features/freelancer/domain/repos/offer_repository/offer_repository.dart';
@injectable

class SendOfferUseCase {
  
  final OfferRepository  offerRepository;
  
  const SendOfferUseCase({required this.offerRepository});

  Future<Either<Failures,OfferEntity>> call(OfferEntity order) => offerRepository.placeOffer(order);
  
}